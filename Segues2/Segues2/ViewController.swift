//
//  ViewController.swift
//  Segues2
//
//  Created by Chan Jung on 7/9/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func buttonPressed(_ sender: Any) {
        performSegue(withIdentifier: "gotoSecondScreen", sender: self)
    }
    

}

