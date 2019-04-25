//
//  ViewController.swift
//  Dicee
//
//  Created by Chan Jung on 4/24/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var ramdomDiceIndex1 : Int = 0
    var randomDiceIndex2 : Int = 0
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDiceImages()
        // Do any additional setup after loading the view.
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
            updateDiceImages()
    }


    @IBAction func rollButtonPressed(_ sender: UIButton) {
        updateDiceImages()
    }
    
    func updateDiceImages() {
        ramdomDiceIndex1 = Int.random(in: 1...6)
        randomDiceIndex2 = Int.random(in: 1...6)
        
        var number_1 = "\(ramdomDiceIndex1)"
        var number_2 = "\(randomDiceIndex2)"  // same as String.valueOf(int) in java
        
        var dice1 = "dice"+number_1
        var dice2 = "dice"+number_2
        print(dice1)
        print(dice2)
        
        diceImageView1.image = UIImage(named: dice1)
        diceImageView2.image = UIImage(named: dice2)
    }
}

