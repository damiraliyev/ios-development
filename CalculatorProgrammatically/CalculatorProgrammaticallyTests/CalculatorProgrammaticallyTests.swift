//
//  CalculatorProgrammaticallyTests.swift
//  CalculatorProgrammaticallyTests
//
//  Created by Damir Aliyev on 22.09.2022.
//

import XCTest
@testable import CalculatorProgrammatically

class CalculatorProgrammaticallyTests: XCTestCase {
    var model: Model!
    var vc = ViewController()
    var calcVC = CalculatorViewController()

    override func setUp() {
        super.setUp()
        model = Model()
    }
    
    func testPerformOperation() throws {
        let firstNumber = "15"
        model.digitString = firstNumber
        let result = model.performOperation("+")
        
        XCTAssertEqual(15.0, result)
    }
    
    func testPerformOneActionOperationClear() throws {
        vc.model.digitString = "154"

        let result = model.performOneActionOperation("C")
        
        XCTAssertEqual(result, "")
    }
    
    func  testPerformOneActionOperationChangeSign() throws {
        vc.model.digitString = "7"

        let result = vc.model.performOneActionOperation("+/-")
        
        XCTAssertEqual(result, "-7.0")
    }
    
    func testPerformOneActionOperationPercent() throws {
        vc.model.digitString = "7"
        
        let result = vc.model.performOneActionOperation("%")
        
        XCTAssertEqual(result, "0.07")
    }
    
    func testCalculateResultAdd() throws {
        vc.model.containerVar = 15
        vc.model.digitString = "27"
        vc.model.sign = "+"
        
        let result = vc.model.calculateResult()
        
        XCTAssertEqual(result, 42)
    }
    
    func testCalculateResultSubtract() throws {
        vc.model.containerVar = 15
        vc.model.digitString = "27"
        vc.model.sign = "-"
        
        let result = vc.model.calculateResult()
        
        XCTAssertEqual(result, -12)
    }
    
    
    func testCalculateResultMultiply() throws {
        vc.model.containerVar = 15
        vc.model.digitString = "27"
        vc.model.sign = "x"
        
        let result = vc.model.calculateResult()
        
        XCTAssertEqual(result, 405)
    }
    
    
    func testCalculateResultDivide() throws {
        vc.model.containerVar = 45
        vc.model.digitString = "15"
        vc.model.sign = "÷"
        
        let result = vc.model.calculateResult()
        
        XCTAssertEqual(result, 3)
    }
    
    
    
    
    
}
