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
        let operation = sender.currentTitle!
        history.text = history.text! + operation
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "-": performOperation { $1 - 0 }
        case "√": performOperation { sqrt($0) }
        case "sin": performOperation { sin($0) }
        case "cos": performOperation { cos($0) }
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    // http://stackoverflow.com/questions/29457720/compiler-error-method-with-objective-c-selector-conflicts-with-previous-declara
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("\(operandStack)")
        history.text = history.text! + " "
    }

    @IBAction func onClear(sender: UIButton) {
        display.text = "0"
        history.text = ""
    }
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

