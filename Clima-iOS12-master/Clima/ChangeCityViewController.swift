//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit


//Write the protocol declaration here:
// if you want to de the delegate, you have to be able to implement userEnteredANewCityName() method
// what protocol does is that it just declare it, it doesnt define the method, it just puts it out there
// the class that implements the protocol will be responsible to define the specific functionality of ALL the methods in here.
// yeah right, you need to define ALL of the methods in here
// you know, like an Abstract class. 
protocol ChangeCityDelegate {  // this will transfer the info back to the other class
    func userEnteredANewCityName (cityName : String)
}


class ChangeCityViewController: UIViewController {
    
    //Declare the delegate variable here:
    var delegate : ChangeCityDelegate?
    
    //This is the pre-linked IBOutlets to the text field:
    @IBOutlet weak var changeCityTextField: UITextField!

    
    //This is the IBAction that gets called when the user taps on the "Get Weather" button:
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        
        
        //1 Get the city name the user entered in the text field
        let cityName = changeCityTextField.text!
        
        //2 If we have a delegate set, call the method userEnteredANewCityName
        delegate?.userEnteredANewCityName(cityName: cityName) // if delegate is not NIL, then call this function
        // this is called optional chaining
        
        //3 dismiss the Change City View Controller to go back to the WeatherViewController
//        so basically, ChangeCityViewController is stacked on top of the WeatherViewController, and this dismisses ChangeCityViewController
        // si it goes back to the first viecontroller
        self.dismiss(animated: true, completion: nil)
        
    }
    
    

    //This is the IBAction that gets called when the user taps the back button. It dismisses the ChangeCityViewController.
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
