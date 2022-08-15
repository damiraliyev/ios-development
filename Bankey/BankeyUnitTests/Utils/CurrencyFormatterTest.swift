//
//  CurrencyFormatterTest.swift
//  BankeyUnitTests
//
//  Created by Damir Aliyev on 10.08.2022.
//

import Foundation
import XCTest

@testable import Bankey

class CurrencyFormatterTest: XCTestCase{
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testBreakintToDollarAndCents() throws {
        let result = formatter.breakIntoDollarsAndCents(994549.45)
        XCTAssertEqual(result.0, "994,549")
        XCTAssertEqual(result.1, "45")
    }
    
    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(994549.45)
        XCTAssertEqual(result, "$994,549.45")
    }
    func testZeroDollarFormatted() throws{
        let ressult = formatter.dollarsFormatted(0)
        
        XCTAssertEqual(ressult, "$0.00")
    }
}
