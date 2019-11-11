//
//  ViewController.swift
//  HitList
//
//  Created by Chan Jung on 11/11/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController{
    var people : [NSManagedObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBAction func addEntry(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Name", message: "ummm message", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "enter smth, idk"
            textField = alertTextField
        }
        let addingAction = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            self.save(name : textField.text!)
            self.tableView.reloadData()
            print(textField.text!)
        }
        let cancelAction = UIAlertAction(title: "nvm", style: .cancel)
        alert.addAction(addingAction)
        alert.addAction(cancelAction)
        //print(names)
        present(alert,animated: true,completion: nil)
    }
    
    // MARK -------------------------make save method----------------------------------------------
    
    func save(name : String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //1
        let managedContext = appDelegate.persistentContainer.viewContext
        //2
        let entry = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
    
        let person = NSManagedObject(entity: entry, insertInto: managedContext)
        //3
        person.setValue(name, forKey: "name")
        //4
        do{
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("cannot save, \(error), \(error.userInfo)")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Da Lyst"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cells")  // cells, interlinke? interlinked. Do they keep you in a little
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do{
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print ("fetch fail, \(error), \(error.userInfo)")
        }
    }

    // MARK ----------------tableview protocol ------------------
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)
        let person = people[indexPath.row]
        cell.textLabel?.text = person.value(forKey: "name") as? String
        print("reloaded")
        return cell
    }
}
