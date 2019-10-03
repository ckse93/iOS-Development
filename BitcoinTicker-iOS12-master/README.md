
#  Bitcoin Ticker
  
  this app will use 2 cocoapod, SwiftyJSON and Alamofire to get bitcoin information from web and display the current value.
  Great reminder that you should have bought it years ago and now you spend your life regretting it. This app serves as a good reminder of your failure. 

## Elements 

* UIPickerView - the rolly dolly thing you can roll doll do select information. 
* Alamofire - for sending and getting requests
* swiftyJSON - for json processing

## Flouuuu

we'll set up constants and UI elements before viewDidLoad() like usual.
and we'll set UIPickerview as a self delegate. so we can get info and whatnot.
Since UIPicker is a protocol, you need to define what the functions will do. so you need to define numberOfComponents(), pickerView() and stuff. 
pickerView will then call getBitCoinDate(), which will call updateBitcoinValue(). and the app will display the value of Bitcoin as of that day and refreshen the user disappointment. 
