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
            print ("answerPressed - you chose true")
        } else {
            pickedAnswer = false
            print ("answerPressed - you chose true")
        }
        checkAnswer()
        
        updateUI()
    }
    
    
    func updateUI() {
         if (i < allQuestion.list.count) {
            print ("updateUI : "+"\(i)")
            questionLabel.text = allQuestion.list[i].questionText
            progressLabel.text = "\(i)"
            nextQuestion()
            scoreLabel.text = "\(score)"
            progressLabel.text = "\(i+1) out of 13"
            progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat (i)
         } else {
            startOver()
        }
    }
    

    func nextQuestion() {
        print("next")
        i+=1
        if i >= allQuestion.list.count+1 {
            let endAlert = UIAlertController(title: "Quiz Done", message: "Do you want to start over?", preferredStyle: .alert)  // making alert popup variable
            let restartAction = UIAlertAction(title: "restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }  // make a button in the endAlert to do what to do
            
            endAlert.addAction(restartAction)
            
            present(endAlert, animated: true, completion: nil)
        }
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
        }
    }
    
    
    func startOver() {
        i = 0
        score = 0
        updateUI()
    }
}
