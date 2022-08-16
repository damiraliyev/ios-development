//
//  AccountSummaryViewControllerTest.swift
//  BankeyUnitTests
//
//  Created by Damir Aliyev on 16.08.2022.
//

import Foundation
import XCTest

@testable import Bankey

class AccountSummaryViewControllerTest: XCTestCase{
    var vc: AccountSummaryViewController!
    var mockManager: MockProfileManager!
    
    class MockProfileManager: ProfileManageable{
        var profile: Profile?
        var error: NetworkError?
        func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
            if error != nil{
                completion(.failure(error!))
                return
            }
            profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
            completion(.success(profile!))
        }
        
        
    }
    
    override func setUp(){
        super.setUp()
        vc = AccountSummaryViewController()
//        vc.loadViewIfNeeded()
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
    }
    
    func testAlertForServerError() throws{
        mockManager.error = .serverError
        vc.forceFetchProfile()
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("Ensure that you are connected to the Internet.Please,try again.", vc.errorAlert.message)
    }
    
    func testAlertForDecodingError() throws{
        mockManager.error = .decodingError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Decoding Error", vc.errorAlert.title)
        XCTAssertEqual("We couldn't process your request. Please,try again.", vc.errorAlert.message)
        
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessageForTest(for: .serverError)
        
        XCTAssertEqual(titleAndMessage.0, "Server Error")
        XCTAssertEqual(titleAndMessage.1, "Ensure that you are connected to the Internet.Please,try again.")
    }
    
    func testTitleAndMessageForDecodingError() throws {
        let titleAndMessage = vc.titleAndMessageForTest(for: .decodingError)
        
        XCTAssertEqual(titleAndMessage.0, "Decoding Error")
        XCTAssertEqual(titleAndMessage.1, "We couldn't process your request. Please,try again.")
    }
    
    
}
