//
//  Model.swift
//  Calculator
//
//  Created by Damir Aliyev on 18.09.2022.
//

import Foundation

import UIKit

struct Model {
    var digitString = ""
    var containerVar = 0.0
    var sign = "."
    var count = 0
    
    mutating func performOperation(_ sender: String?) -> Double {
        count += 1

        if count > 1 {
            let result = calculateResult()
            digitString = String(result)
            sign = "."
            count = 1
        }
        
        if let operationText = sender {

            
            if operationText == "+"{
                if !digitString.isEmpty {
                    saveFirstAndSign(firstOperand: digitString, sign: "+")
                }
            }
            
            if operationText == "-"{
                if !digitString.isEmpty {
                    saveFirstAndSign(firstOperand: digitString, sign: "-")
                }
            }
            
            if operationText == "x"{
                if !digitString.isEmpty {
                    saveFirstAndSign(firstOperand: digitString, sign: "x")
                }
            }
            
            if operationText == "÷"{
                if !digitString.isEmpty {
                    saveFirstAndSign(firstOperand: digitString, sign: "÷")
                }
            }
        }
        return containerVar
    }
    
    mutating func performOneActionOperation(_ sender: String?) -> String {
        if let operationText = sender {
            if operationText == "C" {
                digitString = ""
                containerVar = 0
                sign = "."
                count = 0
            }
            
            if operationText == "+/-" {
                if let digitStringDouble = Double(digitString){
                    let numDisplayed = digitStringDouble * -1
                    digitString = String(numDisplayed)
                } else {
                    digitString = String(containerVar * -1)
                    sign = "."
                }
            }
                
            
            if operationText == "%" {
                // If 5 / -> %
                if Double(digitString) != nil {
                    let numDisplayed = Double(digitString)! / 100
                    digitString = String(numDisplayed)
                } else {
                    digitString = String(containerVar / 100)
                    sign = "."
                }
                
            }
            
            if operationText == "." {
                if isContainDot(numberString: digitString) {
                    digitString += "."
                }
            }
        }
        return digitString
    }
    
    mutating func calculateResult() -> Double {
        guard digitString != "" else { return containerVar}
        
        // 5 -> = -> it will be zero if i won't do that
        guard sign != "." else {
            containerVar = Double(digitString)!
            
            return containerVar
            
        }
        count = 0
        
        if sign == "+" {
//            print(digitString)
            containerVar += Double(digitString)!
            digitString = String(containerVar)
//            print(containerVar)

        }
        
        if sign == "-" {
            containerVar -= Double(digitString)!
            digitString = String(containerVar)
        }
        
        if sign == "x" {
            containerVar *= Double(digitString)!
            digitString = String(containerVar)
        }
        
        if sign == "÷" {
            guard digitString != "0" else {digitString = "0"; return 0.0}
            
            containerVar /= Double(digitString)!
            digitString = String(containerVar)
        }
        // max amount of digits after point
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        
        let number = NSNumber(value: containerVar)
        digitString = formatter.string(from: number)!
        
        //to solve problem with comma, for example formatter will return 1049 as 1,049 which is not compatible with Double(digitString)
        if digitString.contains(",") {
            print(digitString)
            digitString = digitString.replacingOccurrences(of: ",", with: "")
        }
        containerVar = Double(digitString)!
        //Added this
        print(sign)

        return containerVar
    }
    
    
    mutating func dealWithDot( numberString: inout String) -> String {
        let indexOfDot = numberString.firstIndex(of: ".")
        let anotherDot = numberString.lastIndex(of: ".")
        var numberStringCopy = numberString
        
        guard indexOfDot == anotherDot else { return numberString}
        if indexOfDot != nil {
            numberStringCopy = String(numberString[indexOfDot!...])
            print(numberStringCopy)
        } else {
            return numberString
        }
        if numberStringCopy == ".0"{
                numberString.removeSubrange(numberString.firstIndex(of: ".")!..<numberString.endIndex)
        }
        
        return numberString
    }
    
    func isContainDot(numberString: String) -> Bool {
        if numberString.firstIndex(of: ".") != nil {
            return false
        } else {
            return true
        }
    }
    
    mutating func saveFirstAndSign(firstOperand: String, sign: String) {
        containerVar = Double(firstOperand)!
        digitString = ""
        self.sign = sign
    }
}
