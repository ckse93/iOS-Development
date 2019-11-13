//
//  CategoryViewController.swift
//  Todos
//
//  Created by Chan Jung on 11/13/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArr = [Categories]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()
    }
    
    
    // MARK: - Add button pressed method
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Category", message: "adding category", preferredStyle: .alert)
        alert.addTextField { (lalalala) in
            lalalala.placeholder = "add category"
            textField = lalalala 
        }
        
        let cancelAction = UIAlertAction(title: "Cancelll", style: .cancel)
        let addAction = UIAlertAction(title: "Add", style: .default) { (addAction) in
            print ("category adding")
            let newCategory = Categories(context: self.context)
            newCategory.name = textField.text!
            self.categoryArr.append(newCategory)
            self.SaveData()
            self.tableView.reloadData()
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert,animated: true)
    }
    
    // MARK: - tableview datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArr[indexPath.row].name
        return cell
    }
    
    // MARK: - tableview delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        SaveData()
        performSegue(withIdentifier: "gotoItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destionationVC = segue.destination as! ToDoViewListController
        if let index = tableView.indexPathForSelectedRow {
            destionationVC.selectedCategory = categoryArr[index.row]
        }
    }
    
    //MARK: - Save / Load data methods
    func SaveData() {
        do {
            try context.save()
        } catch  {
            print("error saving data" + "\(error)")
        }
    }
    
    func LoadData(with request : NSFetchRequest<Categories> = Categories.fetchRequest()) {
        do {
            try categoryArr = context.fetch(request)
        } catch {
            print("error loading data" + "\(error)")
        }
        tableView.reloadData()
    }
    
    
}
