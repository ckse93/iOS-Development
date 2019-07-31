//
//  ViewController.swift
//  json_into_vxieng
//
//  Created by Chan Jung on 7/25/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import Cocoa
import SwiftyJSON

class ViewController: NSViewController {
    
    let jsonInit = json_box()
    
    var finalstr : String = ""
    
    var firstLine : String = ""
    
    let path = "output.vxieng"

    @IBOutlet weak var label: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
         print (formatBlock(json: jsonInit.json))

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    //--------------------------------------------------------------------------------------------------------
    
    func format_EEC_Mnemonic(str : String) -> String {
// this is used to format EEC_Mnemonic string value. it will return anything before the first + sign.
// if there is no + sign, it will resturn normal input string.
        var returnStr = str
        if let plusSignRance = returnStr.range(of: "+") {
            returnStr.removeSubrange(plusSignRance.lowerBound..<str.endIndex)
        }
        return returnStr
    }
    
    func formatUnit (unit : String) -> String {
        if unit.contains("percent") {
            return unit.replacingOccurrences(of: "percent", with: "%")
        }
        else if unit.contains("degree"){
            return unit.replacingOccurrences(of: "degree", with: "Deg")
        }
        else if unit.contains("vibration"){
            return unit.replacingOccurrences(of: "vibration", with: "vib")
        }
        else if unit.contains("NOUNITS"){
            return unit.replacingOccurrences(of: "NOUNITS", with: "N/A")
        }
        else if unit.contains("NO UNITS"){
            return unit.replacingOccurrences(of: "NO UNITS", with: "N/A")
        }
        else {
            return unit
        }
    }
    
    /*
     for bits table, it has to have
     SOME_UNIQUE_IDENTIFIER(mix it with ACparameter and EEC Menomic maybe?) | BITNUM | 0VAL | 1VAL | LABEL
     
     BITNUM, 0VAL, 1VAL, LABEL, just make them equal to "UNDECIDED" or "UNDEC" so you can track it better later.
     of course, skip the SPAR data type. we dont need that. 
     */
    
    
    /*
     func formatBlock
     this function will parse the json input and generate converted vxieng configuration.
     one formatBlock function call will generate one big string for each Frame (Port) Designation.
     you can copy paste it to the config file.
     it will ignore whitespace and newline char within json.
     */
    func formatBlock (json : JSON) -> String{
        var str = "$RECEIVER "  // first line of the block.
        str += json["pageTables"][0]["tables"][0][2].stringValue.replacingOccurrences(of: " ", with: "") + " PORT=UNDECIDED ACTIVE=UNDECIDED\n*\n" // frame designation
        
        let numberOfPages = json["numPages"].intValue // how many pages?
        
        var lastDatasetDestination = ""
        var bitnum = 1
        
        var i = 0
        while (i<numberOfPages) {
        
            var n = 2  // index 2 is where meaningful data starts.
            while (json["pageTables"][i]["tables"][n][2].stringValue.replacingOccurrences(of: " ", with: "") != "") {  // in completion of this while loop, one row will be written
                let TYPE = json["pageTables"][i]["tables"][n][6].stringValue.replacingOccurrences(of: " ", with: "")
                let EEC = format_EEC_Mnemonic(str:json["pageTables"][i]["tables"][n][7].stringValue.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: ""))
                let DatasetDesignation = json["pageTables"][i]["tables"][n][0].stringValue.replacingOccurrences(of: " ", with: "").uppercased().replacingOccurrences(of: "\n", with: "")
                
                if  TYPE == "SPAR" || json["pageTables"][i]["tables"][n][1].stringValue.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "") == ""{
                    n = n + 1
                    // this if conditional check SPARE type or dummy shit
                }
                    
               else if (json["pageTables"][i]["tables"][n][0].stringValue.replacingOccurrences(of: "\n", with: "") == lastDatasetDestination){
                    //bits concat operation starts here.
                    str.removeLast(11)  //removing $END-FDS
                    let checker = str.suffix(10)
                    if checker == "$END-BITS\n" {
                        str.removeLast(10) // if last word is $END-BITS, then remove that
                    } else {
                        str += "$BITS\n"
                        bitnum = 1
                    }
                    while (json["pageTables"][i]["tables"][n][0].stringValue.replacingOccurrences(of: "\n", with: "") == lastDatasetDestination) {
                        let BIT_TYPE = json["pageTables"][i]["tables"][n][6].stringValue.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
                        if (BIT_TYPE == "SPAR") {
                            n+=1
                        } else {
                            str += format_EEC_Mnemonic(str: json["pageTables"][i]["tables"][n][7].stringValue.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")) + "_"
                                + json["pageTables"][i]["tables"][n][3].stringValue // Start Bit Position
                                 + "BITNUM=" + String(bitnum) + " 0VAL= 1VAL= LABEL=\n"
                            bitnum+=1
                            n+=1
                        }
                    }
                    // do your end BIT operation here.
                    str+="$END-BITS\n$END-FDS\n*\n"
                }
                
                else {
                    str = str + "FDS A1_"
                    str = str + DatasetDesignation + "_FS STATUS=UNDECIDED\n" // Data Designation
                    str = str + "A1_"
                    str = str + EEC // EEC Mnemonic
                    str = str + " TYPE=" + TYPE  // type
                    str = str + " SIZE=UNDECIDED ADDRESS=UNDECIDED"
                    if json["pageTables"][i]["tables"][n][8].stringValue.replacingOccurrences(of: "\n", with: "") != " " { // when signal value is present
                        str += " SIGNALRANGE=\"" + json["pageTables"][i]["tables"][n][8].stringValue.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "") + ".000000 " +
                            json["pageTables"][i]["tables"][n][9].stringValue.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "") + ".000000"
                            + " " + formatUnit(unit : json["pageTables"][i]["tables"][n][13].stringValue.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")) + "\""
                    }
                    lastDatasetDestination = json["pageTables"][i]["tables"][n][0].stringValue.replacingOccurrences(of: "\n", with: "")
                    str += "\n$END-FDS\n*\n"
                    n+=1
                }
            }
            i+=1
        }
        str += "*\n$END-RECEIVER\n********************************************************************************"
        return str
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        print("button pressed")
       // print(inputJSON)
        print ("*-------------------------------------------------------------------------")
        print (formatBlock(json: jsonInit.json))
        print ("*-------------------------------------------------------------------------")
        //print (formatBlock(json: json2))
    }
}

