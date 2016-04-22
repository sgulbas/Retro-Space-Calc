//
//  ViewController.swift
//  Retro-Space-Calculator
//
//  Created by Shale Gulbas on 4/18/16.
//  Copyright © 2016 GulbasDevelopment. All rights reserved.
//

import UIKit
import AVFoundation
    // audio / video fondation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // enable the button audio
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        // do - if there's any problem with this code
        // try - first give it a shot
        // catch - catch the error; if you find it, print the error description
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLabel.text = ""
        
    }

    @IBAction func numberPressed(btn: UIButton!) {
        buttonSound.play()
        
        runningNumber += "\(btn.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(.Multiply)
    }

    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(.Add)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(operation: Operation) {
        playSound()
        
        if currentOperation != .Empty {
           
            // A user selected an operator but then selected another operator without first entering a number
            if runningNumber != "" {
                
                rightValString = runningNumber
                runningNumber = ""
            
                if currentOperation == .Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == .Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == .Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                } else if currentOperation == .Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
            
                leftValString = result
                outputLabel.text = result
            }
            
            currentOperation = operation
            
        } else {
            // This is the first time an operator has been pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        buttonSound.play()
    }

}

