//
//  ViewController.swift
//  Todos
//
//  Created by Chan Jung on 11/5/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import UIKit
import CoreData

class ToDoViewListController: UITableViewController {
    
    var itemArr = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // we are tapping into UIApplication class's shared singleton object, which corrosponds to current App as an object, tapping into its delegate, and we are casting it as AppDelegate
    
    //let saveData =  UserDefaults.standard // we dont use this because it has limitations
    
   let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)  // we use this to see sql data
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        LoadData()
    }
// MARK:TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return itemArr.count
       }
       
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArr[indexPath.row].title
        
        var str = " false"
        if (itemArr[indexPath.row].isDone) {
            str = " true"
        }
        print ("\(indexPath.row)" + str)
        cell.accessoryType = itemArr[indexPath.row].isDone ? .checkmark : .none  // ternery statement. if isdone is true, set it to .checkmark, if else, set to none
        
        return cell
    }
    
    // MARK: ---------------TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  // gets triggered when such cell is selected.
        itemArr[indexPath.row].isDone = !itemArr[indexPath.row].isDone  // toggling in between true and false
        var str = " false"
        if (itemArr[indexPath.row].isDone) {
            str = " true"
        }
        print ("didSelectRowAt " + "\(indexPath.row)" + str)
        SaveData()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true) // if this is not called, a cell will stay selected.
    }
    
    // MARK: --------- add new enetity func
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add entity", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "addy addy "
            textField = alertTextField  // linking outer scope textField with inner scope alertTextField
            print(alertTextField.text!)
        }
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in  // tis gets triggered when you hit 'Add item button'
        
            let newEntry = Item(context: self.context)
            newEntry.title = textField.text!
            newEntry.isDone = false
            self.itemArr.append(newEntry)
            print("now saving...")
            self.SaveData()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancelAction) in
            print ("cancel button pressed")
        }
        
        alert.addAction(action)  // this is mapping alert and action altogher so it can work with each other
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

// MARK: --------------------SaveData()---------------------------------------------------------------------
    
    func SaveData(){
        /* let encoder = PropertyListEncoder()  // not using this on coredata
        do {
            let data = try encoder.encode(itemArr)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding data")
        }*/
        do {
            try context.save()
        } catch {
            print("error saving context, \(error)")
        }
    }
// MARK: -----------------LoadData()---------------------------------------------------------------------
    func LoadData() {
        /*if let data = try? Data(contentsOf: dataFilePath!) {  // optional binding
            let decoder = PropertyListDecoder()
            do {
                itemArr = try decoder.decode([Item].self, from: data) // we tap into 'data' cus optional binding was successful
            } catch {
                print ("error loading data")
            }
        }
*/
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            //try context.fetch(request)
            itemArr = try context.fetch(request)
        } catch {
            print("\(error)")
        }
    }
}

