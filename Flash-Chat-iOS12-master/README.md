
# Flash-Chat

## Project Overview and Objective
- learn how to use tableVIew
    - now with creating custom cells and stuff!
- utilizing Cloud server / local storage to store data
- communicating through google server to connect 2 or more devices together. 
- god im gonna need to buy another phone. great

## Flow
### 0. test. saving data to database 
1. first thing first, cocoapod install.
2. then import the libs you are gonna use and then initialize and configure 
- this is done in `AppDelegate.swift`. Once you launch your app, AppDelegate -> application -> didFinishLaunchingWithOptions is called consecutively. cool. and here is where you init + configure your Firebaseapp
  - `FirebaseApp.configure()`
### 1. Linking ViewControllers with each other
1. using segues, link two VCs together
- as you know, ctrl+click from VC1 and drag to VC2, generating a push segue.
- open up the inspector panel from right hand side, give it a unique identifier 
### 2. Setting up user registration 
- check out firebade iOS doc for more API calls 
0. Selet each password textview and check the box "secure text entry". or not, if you dont value your privacy
1. `import Firebase`
2. Inside `registerPressed()`, 
```swift
Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            if error != nil { // this closure block will be called once it is done. and the closure block will check for error and print statement accordingly
                print(error!)
                // you might want to make a toast if there was an error. So user would know what happened.
            } else {
                print ("registration successful")
            }
        }
```
note that createUser() is asynnchronous 
### 3. After registration, go to chat view
1. use segue that you have defined before. this case, it is "goToChat"
2. inside `createUser()`, if the registration was successful, then go to the chatroom.
3. this is within the closure syntax, so you need
```swift
self.performSegue(withIdentifier: "goToChat", sender: self)
``` 
instead of 
```swift 
performSegue(withIdentifier: "goToChat", sender: self)
```
i mean, if you want to do it outside the closure syntax, you don't have to include `self.` keyword. 

### understanding closure and callback
1. closure is like a nameless function. and it can be passed in as an input parameter. `in` keyword in swuft denotes closure
2. callback function is a function that can be accessible by another function and invoked after the first function is completed, if it does.
3. so in this case, createUser() gets 3 parameters fed in, email and password from views, and closure function parameter, denoted with `in` keyword. Within the createuser(), it will generate `error` or not. if error was generated, that means there was an error. if not, it was successful. this `error` is later then get fed onto closure function parameter **AS A PARAMETER**, doing whatever the thing does. 

### 4. Log out implementation
1. Firebase gives you `signOut()` method, which is **throwable**, meaning that it can generate error and must be handled
2. just wrap that inside the try catch block so when it *throws* error, we can catch that
```swift
do{
  try Auth.auth().signOut()
  navigationController?.popToRootViewController(animated: true)
  }
  catch {
    print("error signing out")
  }
``` 
like so. Note that it's not like java where you can just wrap it up with try-catch block. `try` on swift kinda lets you know where the funky stuff might happen 
3. At this point, this ChatViewController is sitting on top of `WelcomeViewController` -> `RegisterViewCOntroller` These VCs are linked together with `Navigation Controller` and `navigationController?.popToRootViewController(animated: true)` will allow you to skip the middle VC, `RegisterViewCotroller`, and go back to main 
4. just like register, Firebase has `signIn()` method, using closure. you know the drill

#### 5. Sign in implementation 
1. pretty much like Register, but this time, use `signIn()` method for Firebase. and perform segue

### 6. ChatView and table view 
1. it will use two protocols, so you need to extend from there 
```swift
class ChatViewController: UIViewController,UITableViewDelegate, UITableViewDataSource // like so 
```
it means that UIViewController will be the delegate of the tableview. So whatever happens in TableView, UIViewController will be notified, and ChatViewController will be responsible for serving up the data for that TableView. 
2. setting ChatViewController as the delegate for those 
```swift
messageTableView.delegate = self
messageTableView.dataSource = self

```
3. conform to the protocol 
as you know protocol is like an abstract method package. you need to override them to conform to the protocol. 
Xcode would probably complain you didnt conform to it, just hit fix and Xcode will list out method to override.
4. so in this case, we are using custom cell for each tableUIView cell. it is defined under Custom Cell directory.
this custom message cell is linked to `CustomMessageCell` class. `CustomMessageCell` class manages what to display on the custom element thingy, like background, imageview, textview and stuff 
5. go back to `ChatViewController` and under the overriding tableveiew func like this
```swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
    }
    ```
Note that identifier cab be found at MessageCell.xib's identifier section, and give IndexPath just indexPath

## Toolset / skills 
- how to use 3rd party library (using cocoapod and plist), this is another tuesday for me now.
- how to store data in cloud
- how to query cloud database 
- and lets hope it doesnt act like the database i used before... plz
