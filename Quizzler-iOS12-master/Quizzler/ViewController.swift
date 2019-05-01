//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestion = QuestionBank()
    var pickedAnswer : Bool = false
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {  // will run once when the app is loaded
        super.viewDidLoad()
        let firstQuestion = allQuestion.list[0]
        questionLabel.text = firstQuestion.questionText
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if (sender.tag == 1) {
            pickedAnswer = true
        } else {
            pickedAnswer = false
        }
        
        
    }
    
    
    func updateUI() {
      
    }
    

    func nextQuestion() {
        
    }
    
    
    func checkAnswer() {
        
    }
    
    
    func startOver() {
       
    }
    

    
}
