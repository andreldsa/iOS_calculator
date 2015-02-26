//
//  ViewController.swift
//  QuikCalc
//
//  Created by Robert O'Connor on 12/02/2015.
//  Copyright (c) 2015 WIT. All rights reserved.
//

import UIKit

/*
    1. User presses digit - number appended to string (up to 10 digits)
    2. User presses operator:
        - number converted to int
        - operator logged
        - gets ready for next number
    3. User presses =
        - currentTotal displayed (including any calculated value)
    4. User presses C
        - All clear
    5. User presses D:
        - last digit of displayLabel deleted
        - if 0 or 1 digits, back to 0
*/


class ViewController: UIViewController {
    
    // does this require a limiter? So as to only display a certain number of characters?
    @IBOutlet weak var displayLabel: UILabel!
    // or should it be done in InterfaceBuilder?
    
    var calc:Calculator = Calculator()
    
    var display:String = "";
    var currentNumber:String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLabel.text = display
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
        If 0 display, start a new one, otherwise append
    
        If operator set, start new number
    
        Is this it?
    */
    @IBAction func pressNumber(sender: AnyObject) {
        
        if let digit = (sender as UIButton).titleLabel?.text {
            if(displayLabel.text! != "0"){
                displayLabel.text! += digit
                currentNumber += digit
            }
            else{
                displayLabel.text = digit
                currentNumber = digit
            }
        }
    }
    
    func addToCalc(oper:String) {
        calc.addToMemory(currentNumber)
        calc.addToMemory(oper)
        currentNumber = ""
        displayLabel.text! += oper
    }
    
    /*
        If no currentValue, copy in displayLabel. Set operator
        If currentValue, set operator and recalculate
        Is this it?
    */
    @IBAction func pressOperator(sender: AnyObject) {
        let o:String! = (sender as UIButton).titleLabel?.text
        
        if(currentNumber == "") {
            revert()
            var display:String! = displayLabel.text
            if(countElements(display) > 1){
                display = dropLast(display)
            }
            else{
                display = "0"
            }            
            displayLabel.text = "\(display)"

        }
        
        switch(o){
        case "+":
            addToCalc("+")
        case "-":
            addToCalc("-")
        case "x":
            addToCalc("*")
        case "/":
            addToCalc("/")
        default:
            ""
        }
    }

    /*
        Perform calculation and display result
    */
    @IBAction func equalsOp (sender: AnyObject) {
        calc.addToMemory(currentNumber)
        var result = calc.evaluate()
        currentNumber = result
        displayLabel.text = "\(result)"
        calc = Calculator()
    }
    
    /*
        Reset all values
    */
    @IBAction func clearOp (sender: AnyObject) {
        currentNumber = ""
        calc = Calculator()
        
        displayLabel.text = display
    }
    
    func revert() {
        calc.removeLast()
        currentNumber = calc.removeLast()!
    }
    
    /*
        if displayLabel has more than one digit, append
        else reset to 0
    */
    @IBAction func deleteOp (sender: AnyObject) {
        var display:String! = displayLabel.text
        
        if(countElements(display) > 1){
            display = dropLast(display)
            if(currentNumber != "") {
                currentNumber = dropLast(currentNumber)
            } else {
                revert()
            }
        }
        else{
            display = "0"
        }
        
        displayLabel.text = "\(display)"
    }
    
}

