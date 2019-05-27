//
//  selfdrivingcar.swift
//  Classes and Objects
//
//  Created by Chan Jung on 5/26/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import Foundation

class SelfDrivingCar : Car {  // now SelfDrivingCar is a subclass of Car superclass
    var destination : String?  // this is unique for SelfDrivingCar, ? means it might contain NIL value, making it optional value, if you want to use it later, you have to force-unwrap it with "!"
        //  so think of optional as a schrendinger's cat. you put a cat in a box(optional) with a poision bottle. you don't know if the cat is alive or dead until you open the box. same principle. you don't know if the variable is nil or have some value until you unwrap it with ! operator
    var isTesla : Bool
    override init() {
        self.destination = "1 Infinite Loop, CA"  // this has to be called first
        self.isTesla = true
        super.init()  // and then this. 
    }
    convenience init(inputDestionation : String, isthisTesla : Bool) {
        self.init()
        self.destination = inputDestionation
        self.isTesla = isthisTesla
    }
    override func drive() {  // function overriding, re-writing everything
        if let bindingCheck = destination {  // optional binding. basically checking if destination is nil. bind optional variable with another random static variable, if that random variable is successfully created, that means the optional you bind it with is not nil. and you know, if statement is either true or false. and false can mean nil too
            print ("car is self-driving to " + destination!)  //"!" means force unwrapping, it translate String? into String, note that String? and String are different data types. if destination is NIL, you will see NIL pointer exception, your program will crash, your cat will die and you will be sad and eat ice cream until you have heart disease.
        }
        else {
            print ("destination value is nil")
        }
    }
    override func displayInfo() {
        super.displayInfo()  // do everything that the superclass's displayInfo does
        print("this is a self-driving car")  // and do this after.
        if(isTesla){
            print (", and this is a Tesla car")
        }
        else {
            print (", but this is not a Tesla car")
        }
    }
    
}
