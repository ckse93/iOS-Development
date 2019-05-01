//
//  Question.swift
//  Quizzler
//
//  Created by Chan Jung on 4/30/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class Question {
    let questionText : String
    let answer : Bool
    init(text : String, correctAnswer : Bool) {  // initalizaion method
        questionText = text
        answer = correctAnswer
    }
}

class myOtherClass {
    let question = Question(text: "what is the meaning of life?" , correctAnswer: true)
    // this is how you use it. 
}
