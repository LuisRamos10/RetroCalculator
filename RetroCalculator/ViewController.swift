//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Luis Ramos on 1/29/17.
//  Copyright © 2017 Iris. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
        case Clear = "Clear"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
        
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onSubstractPressed(sender: AnyObject) {
        processOperation(operation: .Substract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        processOperation(operation: .Clear)
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Substract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Clear {
                    result = ""
                }
                
                leftValStr = result
                outputLbl.text = result
                
            }
            
            currentOperation = operation
                
        } else {
            
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

}

