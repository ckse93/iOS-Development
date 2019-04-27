import UIKit
func BMIcalculator (height : Double, weight : Int) -> Double {
    let BMI : Double = Double(weight) / (height*height)
    return BMI
}

var bmi = BMIcalculator(height: 178, weight: 70)

if (bmi > 25) {
    print ("you are overweight")
} else if (bmi > 18.5 && bmi < 25) {
    print("you are normal weight")
} else {
    print("you are underweight")
}
