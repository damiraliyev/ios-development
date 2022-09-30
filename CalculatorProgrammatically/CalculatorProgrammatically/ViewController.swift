////
////  ViewController.swift
////  CalculatorProgrammatically
////
////  Created by Damir Aliyev on 18.09.2022.
////
//
//
import UIKit

class ViewController: UIViewController {
    var model = Model(digitString: "", containerVar: 0, sign: ".", count: 0)
    
    let calcVC = CalculatorViewController()

    var digitButtons = [UIButton]()
    var oneActionOperations = [UIButton]()
    var operationButtons = [UIButton]()
    
    
    override func viewDidLoad() {
        digitButtons += [calcVC.button0, calcVC.button1, calcVC.button2, calcVC.button3, calcVC.button4, calcVC.button5, calcVC.button6, calcVC.button7, calcVC.button8, calcVC.button9]
        oneActionOperations += [calcVC.clearButton, calcVC.changeSignButton, calcVC.percentButton, calcVC.dotButton]
        operationButtons += [calcVC.addButton, calcVC.subtractButton, calcVC.multiplyButton, calcVC.divisionButton]
        
        setup()
    }
    
    func setup() {
        addChild(calcVC)
        view.addSubview(calcVC.view)
        calcVC.didMove(toParent: self)
        
        for button in digitButtons {
            button.addTarget(self, action: #selector(digitPressed(_:)), for: .primaryActionTriggered)
        }
        
        for button in operationButtons {
            button.addTarget(self, action: #selector(operationPressed(_:)), for: .primaryActionTriggered)
        }
        
        for button in oneActionOperations {
            button.addTarget(self, action: #selector(oneActionOperationPressed), for: .primaryActionTriggered)
        }
        
        calcVC.equalsButton.addTarget(self, action: #selector(equalsPressed(_:)), for: .primaryActionTriggered)
        
       
    
        
        
    }
    
    @objc func digitPressed(_ sender: UIButton) {
//        guard calcVC.displayLabel.text != "0" && sender.titleLabel?.text != "0" else { return }
        
        if sender.titleLabel?.text == "0" && calcVC.displayLabel.text?.first == "0" {
            return
        }
        
        if calcVC.displayLabel.text == "" && sender.titleLabel?.text == "." {
            model.digitString += "0."
            calcVC.displayLabel.text = model.digitString
        }
        if let titleLableText = sender.titleLabel?.text {
            model.digitString += titleLableText
            calcVC.displayLabel.text = model.digitString
            calcVC.showPressedButton(sender: sender)

        }
    }
    
    @objc func operationPressed(_ sender: UIButton) {
        //        var result = String(model.performOperation(sender.titleLabel?.text))
        calcVC.displayLabel.text = String(model.performOperation(sender.titleLabel?.text))
        let result = model.dealWithDot(numberString: &(calcVC.displayLabel.text)!)
        //        model.digitString = result
        calcVC.displayLabel.text = result
        calcVC.showPressedButton(sender: sender)
   
       }
    
    @objc func oneActionOperationPressed(_ sender: UIButton) {
        if let isContainDot = calcVC.displayLabel.text?.contains(".") {
            if sender.titleLabel?.text == "." && isContainDot {
                return
            }
        }
        
        calcVC.showPressedButton(sender: sender)
        var resultOfOperation = String(model.performOneActionOperation(sender.titleLabel?.text))
        calcVC.displayLabel.text = model.dealWithDot(numberString: &(resultOfOperation))
    }
    
    @objc func equalsPressed(_ sender: UIButton) {
        var result = String(model.calculateResult())
        calcVC.displayLabel.text = model.dealWithDot(numberString: &(result))
    }
    
  
}


