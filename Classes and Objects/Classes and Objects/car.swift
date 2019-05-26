//
//  car.swift
//  Classes and Objects
//
//  Created by Chan Jung on 5/16/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import Foundation

enum CarType {
    case sedan
    case suv
    case crossover
}

class Car {
    var color = "black"
    var numberOfSeats : Int = 5
    var type : CarType = .suv  // make dure the . is there.
    func displayInfo () {
        print(color)
        print(numberOfSeats)
        print(type)
    }
    
    init(){
    }
    
    
    convenience init (cusomerChosenCOlor : String, customerChosenNumberSeats : Int, customerChosenType : CarType){
        self.init() // initializes the default copy of the object
        color = cusomerChosenCOlor
        numberOfSeats = customerChosenNumberSeats
        type = customerChosenType
    }
}