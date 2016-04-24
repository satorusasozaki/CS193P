//
//  main.swift
//  Lecture4_test
//
//  Created by Satoru Sasozaki on 4/22/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import Foundation

print("Hello, World!")



enum Optional<T> {
    case Node
    case Some(T)
}

let x: String? = nil
let x = Optional<String>.None

let x:String? = "hello"
let x = Optional<String>.Some("hello")

// Unwrapping
switch x {
    case Some(let value): y = value
    case None: // raise an exception
}

var a = Array<String>()
var a = [String]()

for animal in animals {
    print("\(animal)")
}

var teamRankings = Dictionary<String, Int>()
var teamRankings = [String:Int]()

teamRankings = ["Stanford":1, "Cal":10]
let ranking = teamRankings["Ohio State"] // ranking is an Int? (Optional<Int>)

// Use a tuple with for-in to enumerate a Dictionary
for (key, value) in teamRankings {
    print("\(key) = \(value)")
}



struct Range<T> {
    var startIndex: T
    var endIndex: T
}


let array = ["a", "b", "c", "d"]
let subArray1 = array[2...3] // subArray1 will be ["c","d"]
let subArray2 = array[2..<3] // subArray2 will be ["c"]
for i in  [27...104] {}



var d: Double = ...
if d.isSignMinus {
    d = Double.abs(d)
}

static func abs(d: Double) -> Double


init?(arg1: Type1) {
    // might return nil in here
}


let image = UIImage(named: "foo") // image is an Optional UIImage (UIImage?)
if let image = UIImage(named: "foo") {
    // image was successfully created
} else {
    // couldn't create the image
}


@IBAction func appendDigit(sender: AnyObject) {
    if let sendingButton = sender as? UIButton {
        let digit = sendingButton.currentTitle!
    } else if let sendingSwitch = sender as? UISwitch {
        
    }
}

let title = (button as UIButton).currentTitle


let vc: UIViewController = CalculatorViewController()
vc.enter
if let calcVC = vc as? CalculatorViewController {
    // can say calcVC.enter()
}

assert(
