//
//  main.swift
//  Classes and Objects
//
//  Created by Chan Jung on 5/16/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import Foundation

//print("Hello, World!")

let myCar = Car()
print (myCar.color)
print (myCar.type)
print (myCar.numberOfSeats)
print ("\n")

let mycar2 = Car(cusomerChosenCOlor : "Red", customerChosenNumberSeats: 5, customerChosenType: .crossover)
print (mycar2.color)
print (mycar2.type)
print (mycar2.numberOfSeats)
print ("\n")

let mycar3 = Car(cusomerChosenCOlor : "Yellow", customerChosenNumberSeats: 4, customerChosenType: .sedan)
mycar3.displayInfo()
print ("\n")

let myselfDrivingCar = SelfDrivingCar()
myselfDrivingCar.drive()
myselfDrivingCar.displayInfo()


let selfDrivingcar2 = SelfDrivingCar(inputDestionation: "1410 Sherman Lake Rd", isthisTesla: false)
selfDrivingcar2.drive()
selfDrivingcar2.displayInfo()
// right now, i only have initialization for either color or all the parameters. you cannot have "master" initialization method and leave out one or more parameters and expect the compiler to assign the missing parameters 
