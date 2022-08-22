//
//  PasswordCriteriaTest.swift
//  PasswordResetComponentTests
//
//  Created by Damir Aliyev on 22.08.2022.
//

import Foundation
import XCTest

@testable import PasswordResetComponent

class PasswordLengthCriteriaTest: XCTestCase{
    
    override func setUp() {
        super.setUp()
    }
    // 8-32 condition
    func testShort() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567"))
    }
    func testLong() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567"))
    }
    
    func testValidShort() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))
    }
    
    func testValidLong() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("ABCDEFGHIJKLMNOPQRSTUVWXYZ123456"))
    }
}

class PasswordOtherCriteriaTest: XCTestCase{
    
    func testSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("abc"))
    }
    
    func testSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("a bc"))
    }
    
    func testLengthAndNoSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("12345678"))
    }
    
    func testLengthAndNoSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("12345 7"))
    }
    
    func testUppercaseMet() throws {
        XCTAssertTrue(PasswordCriteria.uppercaseMet("abcD"))
    }
    
    func testUppercaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.uppercaseMet("abcd"))
    }
    
    func testLowerCaseMet() throws {
        XCTAssertTrue(PasswordCriteria.lowercaseMet("ABCd"))
    }
    
    func testLowerCaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lowercaseMet("ABCD"))
    }
    
    func testDigitMet() throws {
        XCTAssertTrue(PasswordCriteria.digitMet("a1"))
    }
    
    func testDigitNotMet() throws {
        XCTAssertFalse(PasswordCriteria.digitMet("ab"))
    }
    
//        .,@:?!()$\\/#
    func testSpecialCharacterMet() throws {
        XCTAssertTrue(PasswordCriteria.specialCharacterMet("a.c"))
    }
    
    func testSpecialCharacterNotMet() throws {
        XCTAssertFalse(PasswordCriteria.specialCharacterMet("abc"))
    }
}

