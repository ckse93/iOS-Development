//
//  SecondViewController.swift
//  VCDataexchangePrac
//
//  Created by Chan Jung on 7/12/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import UIKit

protocol doubling {
    func doublingStr(inputStr : String)
}

class SecondViewController: UIViewController {
    
    var displayStr = ""

    @IBOutlet weak var displayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        displayLabel.text = "input from previous screen : " + displayStr
        // Do any additional setup after loading the view.
    }
    @IBAction func goBackButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goback", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goback" {
            let firstVC = segue.destination as! ViewController
            firstVC.str = "going back with " + displayStr
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
