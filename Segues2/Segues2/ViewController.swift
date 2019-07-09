//
//  ViewController.swift
//  Segues2
//
//  Created by Chan Jung on 7/9/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//


/*
 practice opjective :
 
 A. Learn how to navigate from one ViewController to another
    1. you can just make a button, control+drag_click to another ViewConntroller
    2. Or, like an intellectual,
        I. create segue by ctrl+drag_click from first ViewController icon (floating above the screen) to whatever ViewController you want to link.
            You will see an arrow aappear on screen. click it and give it an identity, "gotoSceondScreen" or whatever
        II. make a class file by command+n, name it "secondViewController" subclass of ViewController.
        III. Link the secondViewController class with tje actual second view controller screen by selecting the viewController screen and set the custom class to "SecondViewController" class
        IV. make a button in the first viewcontroller, command+drag_click to the firsr viewcontroller class file, creating an action function.
        V. within the action function, call a method. performSegues, give "gotoSecondScreen" and self as a parameters.
        VI. now run and cliock the button, see of everything works.
 B. Learn how to pass data over the different ViewController.
 
 
 --IF SOMETHISNG IS WRONG, WATCH UDEMY LESSON165 - creatiing and using segues, by Angela Yang
 */





import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        performSegue(withIdentifier: "gotoSecondScreen", sender: self)
    }
    // this is what will be performed after you pressed the button. 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoSecondScreen" {
            let destinationViewController = segue.destination as! SecondViewController
            // telling the compiler what type of the ViewController the desitonal will be. this case, type is SecondViewController tyoe.
            
            if let str : String? = textField.text! {
                destinationViewController.textPassedOver = str
            }
            else {
                print ("textfield is NIL")
            }
        }
        
    }
}

