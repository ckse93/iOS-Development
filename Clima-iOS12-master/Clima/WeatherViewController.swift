//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation  // for using GPS
import Alamofire
import SwiftyJSON

/*
 CoreLocation is apple made library.
 I am delegating WeatherViewConttroller as the delegate of CoreLocation.
 So whenever CoreLocation gets a message, it sends it to WeatherViewController class here.
 in the WeatherViewController::viewDidLoad(), it delegates itself everytime the view is loaded.
 And inside the WeatherViewController class, you need to inherit from all the delegate you will be using
 so, CLLocationManagerDelegate from Apple, and ChangeCityDelegate from you, from ChangecityViewController.swift file
 but in WeatherViewController class, you need to declare that method you will be using form that protocol.
 So you have to declare userENderedANewCity() from ChangeCityDelegate protocol.
 
 if you think this shit is confusing af, then watch the 168. Delegate and protocols Explained
 by Angela Yang, iOS 12 & Swift on Udemy.
 
 */


class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {  // inherts from UIViewController and conforms to the rule of CLLocationManagerDelegate
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"
    /***Get your own App ID at https://openweathermap.org/appid ****/
    

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()  // this works in the background
        print ("weatherDataModel.city = " + weatherDataModel.city)
    }
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData (url : String, parameters : [String : String]) {
        Alamofire.request (url, method: .get, parameters: parameters).responseJSON {
//            method -> to which method will we make an HTTP request? this time, .get method
//            get method gets the data, and does pretty much nothing else
//            once we have all three parameters, Alamofire makes request, and will get a response
//            and we use that response in the following code block
            response in
            if response.result.isSuccess {
                print ("successfully got the weather data")
                
                let weatheraJSON : JSON = JSON(response.result.value!)
//                JSON(blah blah blah) feature comes from SwiftyJSON, not from Swift
//                this will be used in successful cases, so you can safely force unwrapp it
                print("weatherJSON : ")
                self.updateWeatherData(json: weatheraJSON)
//              Since updateWeatherData() is outside of clposure parameters, you need to self. to look outside the closure
                
            } else {  // there was an error during retreving data from the server
                print ("error \(response.result.error)")
                self.cityLabel.text = "connection issue"
            }
        }
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    func updateWeatherData (json : JSON) {
        if let temp = json["main"]["temp"].double { // optional binding!
        // temp is in Kelvin, so we need to make it in DegC.
        let tempstr = "\(Int(temp-237.15))"
        print ("updateWeatherData->tempData = " + tempstr)
        temperatureLabel.text = tempstr
        weatherDataModel.temperature = Int(temp)
        weatherDataModel.condition = Int(json["weather"][0]["id"].double!)
        weatherDataModel.city = json["name"].stringValue
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
        updateUIWithWeatherData()
        }
        else {
            cityLabel.text = "Weather data unavailable"
        }
    }
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    func updateUIWithWeatherData() {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = String(weatherDataModel.temperature-273)
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]  // getting the last of the location array ie the most accurate one
        if location.horizontalAccuracy > 0 {  // checking if location has a meaningful data
            locationManager.stopUpdatingLocation()  // as soon as you get the valid value, stop it. or else it will drain battery like crazy
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let params : [String : String] = ["lat" : "\(latitude)", "lon" : "\(longitude)", "appid" : APP_ID]
            print ("longitude : \(longitude), latitude : \(latitude)")
            
            getWeatherData(url : WEATHER_URL, parameters : params)
        }
    }
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error)
        cityLabel.text = "location unavailable"
    }
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    func userEnteredANewCityName(cityName: String) {
        let param : [String : String] = ["q" : cityName, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: param)
        print (cityName)
    }

    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destionationVC = segue.destination as! ChangeCityViewController
            destionationVC.delegate = self
        }
    }
}
