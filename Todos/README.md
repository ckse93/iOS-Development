# ToDos :pencil:
this is a simple ToDo list application that utilizes CoreData framework

## dev process 
1. goto main storyboard and add TableViewController, make it the initial ViewController by moving an arrow or set it the initial in the property panel, and delete the dangling VC.
2. Click on the prototype cell, and give it an identifier we can use later in swift file.
3. change the name of the main swift file and class name into `ToDoListViewController`, and ToDoListViewController will inherit from `UITableViewController`
    * We do this so we don't have to go through delegating. all the things we need is in `TableViewController` class, and we just inherited from it 
**4. Add navigation controller to TableViewController **
   * select TableViewController, go to 'Editor'(way up there, hidden in the full screen)-> 'Embed in' -> 'Navigation Controller'
   * select Navigation Bar at 'navigation controller scene', change the bar tint to blue 
   * change title text to white at 'Title Text Attribute'
**5. populating tableview with items you put in.**
  ```swift 
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // this will populate the cells with contents 
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) 
        cell.textLabel?.text = itemArr[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count
    }
```
**6. set up override methods for tableviews **
  ```swift 
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
        print(itemArr[indexPath.row]) . // when selecting a cell, print the element on the console 
        tableView.deselectRow(at: indexPath, animated: true) // if this is not called, a cell will stay selected.
    }
```
**7. set up the checkmark **

  inside that func up there, add this: 
  ```swift
  if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
  } else {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
  }
  ```
  this will toggle checkmark on / off when user selects the cell 
  
8. setting up the 'add' button to add entry for the todo list.
    * add 'bar button item' and change 'system item' to 'add' so + sign shows up  
    * open up secobnd pane, open storyboard on the left, and ctrl+drag the button from storyboard to swift code
    * change iboutlet->action, any->UIBarButtonItem, name it `AddButtonPressed`
    * once this is pressed, UIAlert will be summoned with text field
    * you know what? look through the code 
  ```swift
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
            self.tableView.reloadData()
            print(textField.text!)
        } 
        
        alert.addAction(action)  // this is mapping alert and action altogher so it can work with each other
        present(alert, animated: true, completion: nil)
    }
  ```
9. saving data
    * as a global variable,`let saveData = UserDefault.standard` this is a key-value pair we will make use of later on for saving/loading the data
    * within `AddButtonPressed`, wrtie `saveData.set(self.itemArr, forKey: "ToDoListArray")` this is saving `itemArr` as an entity that is retrivible through key, "ToDoListArray"
    * saving data is done, so you need to load it up, so goto AppDelegate.swift and look for `didFinishLaunchingWithOptions`
    * within that override func `print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)` to check the directory and go to thjat directory after you launch it, and see if it saved the new entry data and whatnot
    * :warning: so the problem is that if the list gets long enough, the checkmark up in the lower index item will be reused in later index item, you need class array, instead of string item, to display this shit properly

10. individual checkmark setup
    * we need to convert [String] into [ToDo], class ToDo will have contents, aka, what ToDo element, and isDone, basically if you are done with the task at hand
    * in `didSelectRowAt`, enable toggling between true and false by `itemArr[indexPath.row].isDone = !itemArr[indexPath.row].isDone` and call `reloadData()`, this will call `didSelectRowAt`, and this is where you need to toggle checkmark, and this time, we will use ternary operator like so : 
    ```swift
    cell.accessoryType = itemArr[indexPath.row].isDone ? .checkmark : .none  // ternery statement. if isdone is true, set it to .checkmark, if else, set to none
    ```
11. :heavy_exclamation_mark: right now, 'add' functionality doesn't work, why? it currently uses `UserDefault`, and UserDefault can only store some primitive data types aka it cannot store your custom class array, we need to use different stuff to make this happen 
    * create 
    ```swift 
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    ```
    * in `AddButtonPressed`, delete where you save the data to UserDefault, add this 
    ```swift
    let encoder = PropertyListEncoder()
            do {
                let data = try encoder.encode(self.itemArr) // this will throw error, you need to make your class confrom to protocol.
                try data.write(to: self.dataFilePath!)
            } catch {
                print("error encoding data")
            }
    ```
    * Since it throws error that `item` is not encodable, we need to conform to protocol and make it encodable.
    ```swift
    class Item : Encodable {  // as long as class only has primitive data type aka int, string, double.. it will work
    var Todo : String = ""
    var isDone : Bool = false
    }
    ```
    * ok cool, now lets make `SaveData()`
    ```swift
    func SaveData(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArr)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding data")
        }
    }
    ``` 
    and call this whenever you manipulate data. this will tap on the global variable, so you dont need to pass in data, at the moment 
    
