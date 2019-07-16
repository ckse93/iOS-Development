//
//  ViewController.swift
//  VCDataexchangePrac
//
//  Created by Chan Jung on 7/12/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//


/*
this will utilize the segue feaature to  pass info between ViewControllers
 1. create the protocol and its method
 2. in the class that will use the proptocol, conform to the delegate
 3. create a delegate variable that is type : protocol you just made
 4. in the firstVC, make yourself a delegate to the secondVC's delegate variable. this is possible because firstVC "inherits" from that protocol, making firstVC a subtype of protocol as well.
 5. when in the secondVC, send data back by triggering protocol's method that is linked with the firstVC.
 
 */


import UIKit

class ViewController: UIViewController, CanReceive {

    @IBOutlet weak var firstlabel: UILabel!
    @IBOutlet weak var textInput: UITextField!
    var str = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func button1Pressed(_ sender: Any) {
        performSegue(withIdentifier: "gotoSecond", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoSecond" {
            let secondVC = segue.destination as! SecondViewController
            secondVC.displayStr = textInput.text!
            secondVC.delegate = self
        }
    }
    func dataReceived (data : String) {
        firstlabel.text = (data)
    }

}

