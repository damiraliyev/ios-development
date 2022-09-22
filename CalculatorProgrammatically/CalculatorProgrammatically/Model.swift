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
    var tuple = (".", "0")
    var count = 0
    
    mutating func performOperation(_ sender: String?) -> Double {
        count += 1
        
        if count > 1 {
            let result = calculateResult()
            digitString = String(result)
            tuple.0 = "."
            tuple.1 = "0"
            count = 1

            
        }
        
        if let operationText = sender {

            
            if operationText == "+"{
                if !digitString.isEmpty {
                    containerVar = Double(digitString)!
                    digitString = ""
                    tuple.0 = "+"
                    print(containerVar)
                    print("_------------------")
                    print(count)
                }
            }
            
            if operationText == "-"{
                if !digitString.isEmpty {
                    containerVar = Double(digitString)!
                    digitString = ""
                    tuple.0 = "-"
                    
                }
            }
            
            if operationText == "x"{
                if !digitString.isEmpty {
                    containerVar = Double(digitString)!
                    digitString = ""
                    tuple.0 = "x"
                    
                }
            }
            
            if operationText == "÷"{
                if !digitString.isEmpty {
                    containerVar = Double(digitString)!
                    digitString = ""
                    tuple.0 = "÷"
                    print(containerVar)
                    print("_------------------")
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
                tuple.0 = "."
                tuple.1 = "0"
                count = 0
            }
            
            if operationText == "+/-" {
                if let digitStringDouble = Double(digitString){
                    let numDisplayed = digitStringDouble * -1
                    digitString = String(numDisplayed)
//                    containerVar = numDisplayed
                    print("\(digitString) digit string in +/-")
                    print("\(containerVar) +/- ")
//                    containerVar = numDisplayed
//                    containerVar = digitStringDouble
                    tuple.1 = digitString
                } else {
                    digitString = String(containerVar * -1)
                    tuple.0 = "."
                }
            }
                
            
            if operationText == "%" {
                // If 5 / -> %
                if Double(digitString) != nil {
                    let numDisplayed = Double(digitString)! / 100
                    digitString = String(numDisplayed)
                } else {
                    digitString = String(containerVar / 100)
                    tuple.0 = "."
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
        guard tuple.0 != "." else {
            containerVar = Double(digitString)!
            
            return containerVar
            
        }
        count = 0
        
        if tuple.0 == "+" {
            print(digitString)
            containerVar += Double(digitString)!
            
            digitString = String(containerVar)
            print(containerVar)
            
            
        }
        
        if tuple.0 == "-" {
            
            
            containerVar -= Double(digitString)!
            digitString = String(containerVar)
            
            
        }
        
        if tuple.0 == "x" {
            containerVar *= Double(digitString)!
            digitString = String(containerVar)
        }
        
        if tuple.0 == "÷" {
            print("\(digitString) Aaaaa PLEASEEE")
            print("\(containerVar) AAAAAAAAAA PLEEEEEEEAAAASEEE")
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
        print("IN EQUALS")
        print(containerVar)
        print("IN EQUALS")
//        digitString = ""
        return containerVar
    }
    
    
    mutating func dealWithDot( numberString: inout String) -> String {
        let indexOfDot = numberString.firstIndex(of: ".")
        let anotherDot = numberString.lastIndex(of: ".")
        var numberStringCopy = numberString
        
        guard indexOfDot == anotherDot else { return numberString}
        if indexOfDot != nil {
            numberStringCopy = String(numberString[indexOfDot!...])
        } else {
            return numberString
        }
        if numberString.contains(".") {
            if numberStringCopy == ".0"{
                numberString.removeSubrange(numberString.firstIndex(of: ".")!..<numberString.endIndex)
//                containerVar = Double(numberString)!
//                digitString = numberString
            }
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
}
