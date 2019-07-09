//
//  SecondViewController.swift
//  Segues2
//
//  Created by Chan Jung on 7/9/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import UIKit

// SECOND VIEW CONTROLLER!!!!!! NOT THE FIRST

class SecondViewController: UIViewController {
    var textPassedOver : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func button2Pressed(_ sender: Any) {
        performSegue(withIdentifier: "backToMain", sender: self)
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
