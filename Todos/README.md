# ToDos :pencil:
this is a simple ToDo list application that utilizes CoreData framework

## dev process 
1. goto main storyboard and add TableViewController, make it the initial ViewController by moving an arrow or set it the initial in the property panel, and delete the dangling VC 
2. Click on the prototype cell, and give it an identifier we can use later in swift file
3. change the name of the main swift file and class name into `ToDoListViewController`, and ToDoListViewController will inherit from `UITableViewController`.
  3-1. We do this so we don't have to go through delegating. all the things we need is in `TableViewController` class, and we just inherited from it 
4. Add navigation controller to TableViewController 
  4-1. select TableViewController, go to 'Editor'(way up there, hidden in the full screen)-> 'Embed in' -> 'Navigation Controller'
  4-2. select Navigation Bar at 'navigation controller scene', change the bar tint to blue 
  4-3. change title text to white at 'Title Text Attribute'
5. populating tableview with items you put in.
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
6. set up override methods for tableviews 
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
7. set up the checkmark 
  inside that func up there, add this: 
  ```swift
  if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
  } else {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
  }
  ```
  this will toggle checkmark on / off when user selects the cell 
