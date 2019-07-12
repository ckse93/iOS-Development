//
//  ViewController.swift
//  VCDataexchangePrac
//
//  Created by Chan Jung on 7/12/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//


/*
this will utilize the segue feaature to  pass info between ViewControllers
 
 1. make a second viewcontroller class.
 2. make a second viecontroller on the storyboard and link it to class, SecondVideController.
 3. make a segue from first VC to secondVC, name it "gotoSecond"
 4. make a button on first VC, and link it to the class file
 5. write following functions.
    I. prepare(for segue) - to tell what to do when segue is triggered
    II. inside the button pressed func, write performSegue with identifier
    III. 
 
 */


import UIKit

class ViewController: UIViewController, doubling {

    @IBOutlet weak var textInput: UITextField!
    var str = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        doublingStr(inputStr: str)
    }
    @IBAction func button1Pressed(_ sender: Any) {
        performSegue(withIdentifier: "gotoSecond", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoSecond" {
            let secondVC = segue.destination as! SecondViewController
            secondVC.displayStr = textInput.text!
        }
    }
    
    func doublingStr(inputStr : String) {
        print ("protocol successful! " + inputStr)
    }

}

