//
//  Calculator.swift
//  QuikCalc
//
//  Created by André Abrantes on 25/02/2015.
//  Copyright (c) 2015 WIT. All rights reserved.
//

import UIKit

extension String {
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
    
    func toInt() -> Int? {
        return NSNumberFormatter().numberFromString(self)?.integerValue
    }
}

class Calculator {
    var memory = Array<String>()
    
    func sum(num1: Double,num2: Double) -> Double {
        return num1 + num2
    }
    
    func sub(num1: Double,num2: Double) -> Double {
        return num1 - num2
    }
    
    func multiple(num1: Double, num2: Double)-> Double {
        return num1*num2
    }
    
    func divide(num1: Double, num2: Double)-> Double {
        return num1/num2
    }
    
    func addToMemory(element: String) {
        memory.append(element)
    }
    
    func removeLast() -> String? {
        var result = memory.last
        memory.removeLast()
        return result
    }
    
    // Evaluate precedence major (multiplication and division)
    
    func evaluate() -> String {
        for var i = 0; i < memory.count; i++  {
            let str = memory[i]
            if let num = str.toDouble() {
            } else {
                var result = 1.0
                switch memory[i] {
                case "/":
                    result = divide(memory[i-1].toDouble()!, num2: memory[i+1].toDouble()!)
                    memory[i-1] = "\(result)"
                    memory.removeRange(i...i+1)
                    i = i-2
                case "*":
                    result = multiple(memory[i-1].toDouble()!, num2: memory[i+1].toDouble()!)
                    memory[i-1] = "\(result)"
                    memory.removeRange(i...i+1)
                    i = i-2
                default:
                    ""
                }
                
            }
        }
        
        // Evaluate precedence minor (sum and subtraction)
        
        for var i = 0; i < memory.count; i++  {
            let str = memory[i]
            if let num = str.toDouble() {
            } else {
                var result = 1.0
                switch memory[i] {
                case "+":
                    result = sum(memory[i-1].toDouble()!, num2: memory[i+1].toDouble()!)
                    memory[i-1] = "\(result)"
                    memory.removeRange(i...i+1)
                    i = i-2
                case "-":
                    result = sub(memory[i-1].toDouble()!, num2: memory[i+1].toDouble()!)
                    memory[i-1] = "\(result)"
                    memory.removeRange(i...i+1)
                    i = i-2
                default:
                    ""
                }
            }
        }
        var result = memory[0]
        if(result.toDouble()! % 1 == 0.0) {
            result = "\(result.toInt()!)"
        }
        return result
    }
    
}
