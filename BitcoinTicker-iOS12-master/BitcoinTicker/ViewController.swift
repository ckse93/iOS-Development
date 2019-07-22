import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var currency = ""
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
       currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }

    // UIPickerView delegate methods here
    // the rolly thingy maky---------------------------------------------------------------------------------A
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // this particular method is called everytime you make a selection in the rolly thiny
        finalURL = baseURL + currencyArray[row]
        currency = currencyArray[row]
        print(finalURL)
        getBitcoinDate(url: finalURL)
    }
    // the rolly thingy maky---------------------------------------------------------------------------------A
//    
//    //MARK: - Networking
//    /***************************************************************/
    func getBitcoinDate (url: String) {
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                print ("successfully got the data")
                let BitCoinJSON : JSON = JSON (response.result.value)
                self.updateBitcoinValue (json : BitCoinJSON)
            }
            else {
                print ("failed to get relavant data")
            }
        }
    }

//    //MARK: - JSON Parsing
//    /***************************************************************/
    
    func updateBitcoinValue (json : JSON) {
        print ("launching updateBitcoinValue func...")
        print(json)
        print("Bitcoin Price RN is : " + json["last"].stringValue)
        bitcoinPriceLabel.text = json["last"].stringValue + currency
    }




}

