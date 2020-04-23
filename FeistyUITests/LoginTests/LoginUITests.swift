//
//  FeistyUITests.swift
//  FeistyUITests
//
//  Created by Tiewhan Smith on 2020/02/04.
//  Copyright © 2020 DVT. All rights reserved.
//

import XCTest
@testable import Feisty
@testable import CommonFiles

class LoginUITests: LoginTestCase {

  func testGivenRightCredentialsWhenLoginIsCalledThenGiveGoodResponse() {
    
    application.launch()
    
    let testUsername = "tiewhan"
    let testPassword = "cat3"
    
    loginUser(with: testUsername, and: testPassword)
    
    application.alerts["Login Message"].buttons["Dismiss"].tap()
    
    sleep(1)
    
    XCTAssert(application.staticTexts["Games"].exists)
    snapshot("01LoginScreen")
    
  }
  
  func testGivenWrongCredentialsWhenLoginIsCalledThenGiveBadResponse() {
    
    application.launch()
    
    let testUsername = "Tiewhan"
    let testPassword = "cat3"
    
    loginUser(with: testUsername, and: testPassword)
    
    sleep(1)
    
    XCTAssert(application.alerts["Login Message"].staticTexts["Failed To Log In"].exists)
    snapshot("02LoginScreen")
    
  }
  
  func testGivenPasswordButNoUsernameWhenLoginIsCalledThenGiveNegativeResponse() {
    
    application.launch()
    
    let testUsername = ""
    let testPassword = "cat3"
    
    loginUser(with: testUsername, and: testPassword)
    
    sleep(1)
    
    XCTAssert(application.alerts["Login Message"].staticTexts["Failed To Log In"].exists)
    snapshot("03LoginScreen")
    
  }
  
  func testGivenUsernameButNoPasswordWhenLoginIsCalledRThenGiveNegativeRepsonse() {
    
    application.launch()
    
    let testUsername = "tiewhan"
    let testPassword = ""
    
    loginUser(with: testUsername, and: testPassword)
    
    sleep(1)
    
    XCTAssert(application.alerts["Login Message"].staticTexts["Failed To Log In"].exists)
    snapshot("04LoginScreen")
    
  }
  
  func testGivenNoUsernameOrPasswordWhenLoginIsCalledThenGiveNegativeResponse() {
    
    application.launch()
    
    let testUsername = ""
    let testPassword = ""
    
    loginUser(with: testUsername, and: testPassword)
    
    sleep(1)
    
    XCTAssert(application.alerts["Login Message"].staticTexts["Failed To Log In"].exists)
    snapshot("05LoginScreen")
    
  }
  
}
