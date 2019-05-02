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
    var i = 0
    var score = 0
    
    override func viewDidLoad() {  // will run once when the app is loaded
        super.viewDidLoad()
        let firstQuestion = allQuestion.list[0]
        questionLabel.text = firstQuestion.questionText
        i += 1
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if (sender.tag == 1) {
            pickedAnswer = true
        } else {
            pickedAnswer = false
        }
        checkAnswer()
        updateUI()
    }
    
    
    func updateUI() {
         if (i < allQuestion.list.count) {
            questionLabel.text = allQuestion.list[i].questionText
            progressLabel.text = "\(i)"
            nextQuestion()
         } else {
            return
        }
    }
    

    func nextQuestion() {
        i+=1
    }
    
    
    func checkAnswer() {
        if (i < allQuestion.list.count) {
            let correctAnswer = allQuestion.list[i].answer
            if (correctAnswer == pickedAnswer) {
                score += 1
                print ("correct")
            } else {
                print("wrong")
            }
            print (i)
        } else {
            startOver()
        }
    }
    
    
    func startOver() {
       
    }
}
