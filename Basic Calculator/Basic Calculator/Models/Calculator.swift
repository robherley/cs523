//
//  Calculator.swift
//  Basic Calculator
//
//  Created by Robert Herley on 1/29/19.
//  Copyright © 2019 Robert Herley. All rights reserved.
//

import Foundation

class Calculator {
    
    enum Operation : String {
        case Add = "+"
        case Subtract = "-"
        case Multiply = "×"
        case Divide = "÷"
        case Invert = "±"
        case Equal = "="
        case Clear = "C"
        case Percent = "%"
    }
    
    typealias BinaryFunc = (Double, Double) -> Double
    private var binaryOps : [Operation : BinaryFunc] = [
        Operation.Add: { $0 + $1 },
        Operation.Subtract: { $0 - $1 },
        Operation.Multiply: { $0 * $1 },
        Operation.Divide: { $0 / $1 },
    ]
    
    private var pending : Pending?
    struct Pending {
        var operation: Operation
        var operand : Double
    }
    
    var store = 0.0
    
    func compute(op pressedOp : Operation, num newOperand : Double) {
        switch pressedOp {
        case .Add, .Subtract, .Multiply, .Divide:
            if pending != nil {
                store = binaryOps[(pending?.operation)!]!(pending!.operand, newOperand)
                pending = nil
            } else {
                store = newOperand
            }
            pending = Pending(operation: pressedOp, operand: newOperand)
        case .Invert:
            store = -newOperand
        case .Clear:
            pending = nil
            store = 0.0
        case .Percent:
            store /= 100
        case .Equal:
            if pending != nil {
                store = binaryOps[(pending?.operation)!]!(pending!.operand, newOperand)
                pending = nil
            }
        }
        
    }
}
