//
//  ViewController.swift
//  Todos
//
//  Created by Chan Jung on 11/5/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import UIKit

class ToDoViewListController: UITableViewController {
    
    var itemArr = [Item]()
    
    let saveData =  UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.Todo = "tell Mike"
        itemArr.append(newItem)
        let newItem1 = Item()
        newItem1.Todo = "prep for iOS"
        itemArr.append(newItem1)
        let newItem2 = Item()
        newItem2.Todo = "go home"
        itemArr.append(newItem2)
        let newItem3 = Item()
        newItem3.Todo = "kiss wifey"
        itemArr.append(newItem3)
        let newItem4 = Item()
        newItem4.Todo = "lol"
        itemArr.append(newItem4)
        let newItem5 = Item()
        newItem5.Todo = "lalalalla"
        itemArr.append(newItem5)
        
        
        if let loadData = saveData.array(forKey: "ToDoListArray") as? [Item] {
            itemArr = loadData
            tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
// MARK ------- TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return itemArr.count
       }
       
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArr[indexPath.row].Todo
        
        var str = " false"
        if (itemArr[indexPath.row].isDone) {
            str = " true"
        }
        print ("\(indexPath.row)" + str)
        if (itemArr[indexPath.row].isDone) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    // MARK ---------------TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  // gets triggered when such cell is selected.
        itemArr[indexPath.row].isDone = !itemArr[indexPath.row].isDone
        var str = " false"
        if (itemArr[indexPath.row].isDone) {
            str = " true"
        }
        print ("didSelectRowAt " + "\(indexPath.row)" + str)
        tableView.reloadData()
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
            let newEntry = Item()
            newEntry.Todo = textField.text!
            self.itemArr.append(newEntry)
            print("now saving...")
            self.saveData.set(self.itemArr, forKey: "ToDoListArray")
            self.tableView.reloadData()
            print(newEntry.Todo)
        } 
        
        alert.addAction(action)  // this is mapping alert and action altogher so it can work with each other
        present(alert, animated: true, completion: nil)
    }
    
}

