//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation  // foundation for audio visual components

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var AudioPlayer : AVAudioPlayer!  // audio player variable

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func notePressed(_ sender: UIButton) {
        print (sender.tag)  // track down which one was the signal from, returns the tag
        var note_number = "note"+"\(sender.tag)"
        let soundURL = Bundle.main.url(forResource: note_number, withExtension: "wav")  //setup the location of the local wav file
        
        do {
            AudioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        } catch {
            print(error)
        }
        AudioPlayer.play()
    }
    
  

}

