//
//  ViewController.swift
//  Basic Calculator
//
//  Created by Robert Herley on 1/27/19.
//  Copyright © 2019 Robert Herley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentLabel: UILabel!
    private var calc = Calculator()
    private var typing = false // keep track if the user typed
    
    private var currentOperand : Double {
        get {
            return Double(currentLabel.text!)!
        }
        set {
            currentLabel.text = String(format: "%g", newValue)
        }
    }
    
    @IBAction func pressNum(_ sender: UIButton) {
        print("Pressed Num: \(sender.currentTitle!)")
        if typing {
            currentLabel.text! += sender.currentTitle!
        } else {
            currentLabel.text = sender.currentTitle!
        }
        typing = true
    }
    
    @IBAction func pressOp(_ sender: UIButton) {
        print("Pressed OP: \(sender.currentTitle!)")
        typing = false
        calc.compute(op: Calculator.Operation(rawValue: sender.currentTitle!)!, num: currentOperand)
        currentOperand = calc.store
    }
}
