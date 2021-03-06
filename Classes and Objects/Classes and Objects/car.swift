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
    
    fileprivate var color = "black"  // fileprivate is basically "protected" in C++
    fileprivate var numberOfSeats : Int = 5
    fileprivate var type : CarType = .suv  // make dure the . is there.
    func displayInfo () {
        print(color)
        print(numberOfSeats)
        print(type)
    }
    func drive(){
        print ("car is moving")
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
