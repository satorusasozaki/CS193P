//
//  CalculatorBrain.swift
//  Assignment1_calculator
//
//  Created by Satoru Sasozaki on 4/21/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    var variableValues: Dictionary<String,Double>?
    
    // http://ufcpp.net/study/csharp/st_enum.html
    // 特定の値しか取らないようなもの（例えば曜日など）に対して使う型
    private enum Op: CustomStringConvertible {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        case Variable(String)
        var  description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                case .Variable(let variable):
                    return variable
                }
            }
        }
    }
    
    private var opStack = [Op]()         // Array<Op>
    private var knownOps = [String:Op]() // Dictionary<String, Op>()
    
    // Initializer will get called when
    // // let brain = CalculatorBrain()
    init() {
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷", {$1 / $0}))
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("−", {$1 - $0}))
        learnOp(Op.UnaryOperation("√", sqrt))
        variableValues = [String:Double]()
    }
    // tuple is a small struct
    // there is hidden let in front of ops: [Op], let ops: [Op]
    // if you passe parameter by value, it is always constant
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            // ops is immutable array passed by value as let
            // to make it mutable, copy it to var
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            case .Variable(let variable):
                return (variableValues![variable], remainingOps)
            }
        }
        return (nil,ops)
    }
    
    // Make it optional because if stack is empty and try to do '+', then the return value will be nil
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        print("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func pushOperand(symbol: String) -> Double? {
        opStack.append(Op.Variable(symbol))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        // Dictionary value is always OPTIONAL because it might be nil
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}