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
    var selectedCategory : Categories? {
        didSet{  // this blok will execute as selectedCategory get set with a value
            print ("data has been set!")
            LoadData()
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // we are tapping into UIApplication class's shared singleton object, which corrosponds to current App as an object, tapping into its delegate, and we are casting it as AppDelegate
   let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)  // we use this to see sql data
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        LoadData()
    }
// MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return itemArr.count
       }
       
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.accessoryType = itemArr[indexPath.row].isDone ? .checkmark : .none  // ternery statement. if isdone is true, set it to .checkmark, if else, set to none
        let strikeEffect: [NSAttributedString.Key : Any] = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.strokeColor: UIColor.black]
        let attrString : NSAttributedString = NSAttributedString(string: itemArr[indexPath.row].title ?? "", attributes: strikeEffect)
        if itemArr[indexPath.row].isDone {
            cell.textLabel?.attributedText = attrString
        } else {
            cell.textLabel?.attributedText = NSAttributedString(string: itemArr[indexPath.row].title ?? "")
        }
        return cell
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  // gets triggered when such cell is selected.
        itemArr[indexPath.row].isDone = !itemArr[indexPath.row].isDone  // toggling in between true and false
        SaveData()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true) // if this is not called, a cell will stay selected.
    }
    
    // MARK: - add new enetity func
    
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
            newEntry.parentCategory = self.selectedCategory
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

// MARK: - SaveData()
    
    func SaveData(){
        do {
            try context.save()
        } catch {
            print("error saving context, \(error)")
        }
    }
// MARK: - LoadData()
    func LoadData(with request : NSFetchRequest<Item> = Item.fetchRequest()) {  // "with" for external call, and if there is no argument, Item.fetchRequest() is the default parameter
        let predicate = NSPredicate(format: "parentCategory.name MATCHES[cd] %@", selectedCategory!.name!)
        print("selectedCategory:" + selectedCategory!.name!)
        request.predicate = predicate
        do {
            //try context.fetch(request)
            itemArr = try context.fetch(request)
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
    }

}

//MARK: - Search Bar Methods
extension ToDoViewListController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {  // query data here
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)  // this will look for the searchBar.text within title colum inside the CoreData, ignoridng case and dialects
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        print("searching : " + searchBar.text!)
        // now register predicate and sortDestriptor
        request.predicate = predicate
        request.sortDescriptors = [sortDescriptor]
        LoadData(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {  // whenever there is a change in textbar
        if searchBar.text?.count == 0 {
            LoadData()
            DispatchQueue.main.async {  // assigning this task to main thread
                searchBar.resignFirstResponder()  // dismissing keyboard and flashing cursor
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text? = ""
        LoadData()
        DispatchQueue.main.async {  // assigning this task to main thread
            searchBar.resignFirstResponder()  // dismissing keyboard and flashing cursor
        }
    }
}
