//
//  ViewController.swift
//  Assignment1_calculator
//
//  Created by Satoru Sasozaki on 4/5/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!

    var userIsInTheMiddleOfTypingANumber: Bool = false
    var pointIsEntered: Bool = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        history.text = history.text! + digit
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func onDecimalPoint(sender: UIButton) {
        history.text = history.text! + sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + sender.currentTitle!
        } else {
            display.text = "0" + sender.currentTitle!
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func onPi(sender: UIButton) {
        history.text = history.text! + sender.currentTitle!
        let x = M_PI
        if !userIsInTheMiddleOfTypingANumber {
            display.text = "\(x)"
            enter()
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
            history.text = history.text! + operation
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if displayValue != nil {
            if let result = brain.pushOperand(displayValue!) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
        brain.variableValues!["x"] = 25
        print("\(brain.variableValues!["x"]!)")
        
        history.text = history.text! + " "
    }

    @IBAction func onClear(sender: UIButton) {
        display.text = "0"
        history.text = ""
    }
    var displayValue: Double? {
        get {
            return NSNumberFormatter().numberFromString(display.text!)?.doubleValue
        }
        
        set {
            if newValue != nil {
                display.text = "\(newValue!)"
            } else {
                display.text = ""
            }
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

