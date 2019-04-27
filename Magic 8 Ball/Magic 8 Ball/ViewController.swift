//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Chan Jung on 4/27/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewer: UIImageView!
    var ball = "ball"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answer()
    }  // when device shaken, this will called
    
    @IBAction func AskButtonPressed(_ sender: Any) {
        answer()
    }
    
    func answer() {
        var number = Int.random(in: 1...5)
        var ball_number = ball+"\(number)"
        viewer.image = UIImage(named: ball_number)
    }  // generalize a randomized int and convert it to string
        // and then truncate it to "ball" so it can change the
        // image accordningly

}

