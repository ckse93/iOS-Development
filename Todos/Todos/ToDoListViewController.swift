//
//  ViewController.swift
//  Todos
//
//  Created by Chan Jung on 11/5/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import UIKit

class ToDoViewListController: UITableViewController {
    
    var itemArr = ["buy eggs", "cancel chiropractor", "make meme"]
    
    let saveData =  UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        if let loadData = saveData.array(forKey: "ToDoListArray") as? [String] {
            itemArr = loadData
            tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
// MARK ------- TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArr[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count
    }
    
    // MARK ---------------TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  // gets triggered when such cell is selected.
        print(itemArr[indexPath.row])
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark) {  // toggling checkmarks
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true) // if this is not called, a cell will stay selected.
    }
    
    // MARK --------- add new enetity func
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add entity", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "addy addy "
            textField = alertTextField  // linking outer scope textField with inner scope alertTextField
            print(alertTextField.text!)
        }
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in  // tis gets triggered when you hit 'Add item button'
            self.itemArr.append(textField.text!)
            self.saveData.set(self.itemArr, forKey: "ToDoListArray")
            self.tableView.reloadData()
            print(textField.text!)
        } 
        
        alert.addAction(action)  // this is mapping alert and action altogher so it can work with each other
        present(alert, animated: true, completion: nil)
    }
    
}

