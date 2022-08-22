//
//  ViewControllerTests.swift
//  PasswordResetComponentTests
//
//  Created by Damir Aliyev on 22.08.2022.
//

import XCTest

@testable import PasswordResetComponent

class ViewControllerTests_NewPassword_Validation: XCTestCase {

    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }

    /*
     Here we trigger those criteria blocks by entering text,
     clicking the reset password button, and then checking
     the error label text for the right message.
     */
    
    func testEmptyPassword() throws {
        vc.newPasswordText = ""
        vc.setupNewPasswordTest()
        vc.resetButtonTapped(sender: UIButton())
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Enter your password")
    }
    
    func testInvalidPassword() throws {
        vc.newPasswordText = "&"
        vc.setupNewPasswordTest()
        vc.resetButtonTapped(sender: UIButton())
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
    }

    func testCriteriaNotMet() throws {
        vc.newPasswordText = tooShort
        vc.setupNewPasswordTest()
        vc.resetButtonTapped(sender: UIButton())
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text, "Your password must meet requirements below")
    }

    func testValidPassword() throws {
        vc.newPasswordText = "123456Ab."
//        vc.setupNewPasswordTest()
        vc.resetButtonTapped(sender: UIButton())
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text, "")
    }
}


class ViewControllerTests_ConfirmPassword_Validation: XCTestCase {
    
    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testEmptyPassword() throws {
        vc.confirmPasswordText = ""
        vc.setupConfirmTest()
        vc.resetButtonTapped(sender: UIButton())
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Enter your password")
    }
    func testPasswordsDoNotMatch() throws {
        vc.newPasswordText = "123456Ab.213"
        vc.setupNewPasswordTest()
        vc.confirmPasswordText = "123456Ab."
        vc.setupConfirmTest()
        vc.resetButtonTapped(sender: UIButton())
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Passwords don't match")
    }
    
    func testPasswordsMatch() throws {
        vc.newPasswordText =  validPassword
        vc.setupNewPasswordTest()
        vc.confirmPasswordText = validPassword
        vc.setupConfirmTest()
        vc.resetButtonTapped(sender: UIButton())
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "")
    }
    
}

class ViewControllerTests_Show_Alert: XCTestCase {
    var vc: ViewController!
    let validPassword = "123456Aa."
    let tooShort = "1234"
    
    func testShowSuccess() throws {
        vc = ViewController()
        vc.newPasswordText = validPassword
        vc.setupConfirmTest()
        vc.confirmPasswordText = validPassword
        vc.setupConfirmTest()
        
        vc.resetButtonTapped(sender: UIButton())
        
        XCTAssertNotNil(vc.alert)
        XCTAssertEqual(vc.alert?.title, "Success")
    }
    
    func testShowError() throws {
        vc = ViewController()
        vc.newPasswordText = validPassword
        vc.setupConfirmTest()
        vc.confirmPasswordText = tooShort
        vc.setupConfirmTest()
        
        vc.resetButtonTapped(sender: UIButton())
        
        XCTAssertNil(vc.alert)
    }
}
