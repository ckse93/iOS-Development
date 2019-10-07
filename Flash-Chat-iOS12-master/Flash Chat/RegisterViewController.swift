//
//  RegisterViewController.swift
//  Flash Chat
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    
    //Pre-linked IBOutlets

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  // this will handle registration job and t e l e p o r t to the chat view controller.
    @IBAction func registerPressed(_ sender: AnyObject) {
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            // this closure block will be called once it is done. and the closure block will check for error and print statement accordingly
            if error != nil {
                print("ERROR registration!!!!!")
                print(error!)
            } else {
                print ("registration successful")
                self.performSegue(withIdentifier: "goToChat", sender: self)  // this will teleport you to the chat view controller.
                // but this is within the closure block. you need to designate which class this is coming from.
            }
        }
    } 
    
    
}
