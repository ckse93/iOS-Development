
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

## Toolset / skills 
- how to use 3rd party library (using cocoapod and plist), this is another tuesday for me now.
- how to store data in cloud
- how to query cloud database 
- and lets hope it doesnt act like the database i used before... plz
