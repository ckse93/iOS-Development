//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // thi
    
    // Declare instance variables here


    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        // this registers nib aka xib, to this messageTableView with the identifier. if bundle is set to nil, Xcode will search current directory.
        configureTableView()
        //TODO: Set yourself as the delegate of the text field here:
        messageTextfield.delegate = self

        
        
        //TODO: Set the tapGesture here:
        let tabGeature = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tabGeature)
    }
    
    //MARK: - TableView DataSource Methods
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        let messageArr = ["First Message", "Second Message", "Third Message"]
        cell.messageBody.text = messageArr[indexPath.row]
        return cell
    }
    
    
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3  // we got 3 rows
    }
   
    
    //TODO: Declare tableViewTapped here:
    @objc func tableViewTapped() {
        print ("triggered")
        messageTextfield.endEditing(true)
    }
    
    
    
    //TODO: Declare configureTableView here:
    func configureTableView() {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120
    }
    
    //MARK:- TextField Delegate Methods
    
    

    
    //TODO: Declare textFieldDidBeginEditing here:
    func textFieldDidBeginEditing(_ textField: UITextField) {  // this gets trigger when user tabs
          // if something changes, redraw
        UIView.animate(withDuration: 0.5, animations: {  // closure, you know this
            print ("begin typing")
            self.heightConstraint.constant = 308  // 50 is the margin
            self.view.layoutIfNeeded()
        })
    }
    
    
    
    //TODO: Declare textFieldDidEndEditing here:
    func textFieldDidEndEditing(_ textField: UITextField) {  // doesn't get called automatically. you need to call it. if user tabs somewhere other than this view element, shrink it down. you need a tab recognizer to implement this feature
        UIView.animate(withDuration: 0.5) {
            print("done editing")
            self.heightConstraint.constant = 50  // this is default height, you know that right?
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        messageTextfield.endEditing(true)
        
        //TODO: Send the message to Firebase and save it in our database
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        let messageDB = Database.database().reference().child("Messages")
        
        let messageDict = ["Sender" : Auth.auth().currentUser?.email, "MessageBody" : messageTextfield.text!]
        messageDB.childByAutoId().setValue(messageDict) {
            (error, reference) in
            if error != nil {
                print (error)
            } else {
                print ("message saved")
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            }
        }  // creates custom random key and be saved by their own unique id
    }
    
    //TODO: Create the retrieveMessages method here:
    
    

    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        //Auth.auth().signOut() wil
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch {
            print("error signing out")
        }
        // unlike java, it the error handling in swift is wrapped around the do-try-catch block.
    }
    


}
