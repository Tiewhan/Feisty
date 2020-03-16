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

class FeistyUITests: LoginTestCase {

  func testGivenRightCredentialsWhenLoginIsCalledThenGiveGoodResponse() {
    
    application.launch()
    
    let testUsername = "tiewhan"
    let testPassword = "cat3"
    
    loginUser(with: testUsername, and: testPassword)
    
    application.alerts["Login Message"].buttons["Dismiss"].tap()
    
    sleep(1)
    
    XCTAssert(application.staticTexts["Games"].exists)
    
  }
  
  func testGivenWrongCredentialsWhenLoginIsCalledThenGiveBadResponse() {
    
    application.launch()
    
    let testUsername = "Tiewhan"
    let testPassword = "cat3"
    
    loginUser(with: testUsername, and: testPassword)
    
    sleep(1)
    
    XCTAssert(application.alerts["Login Message"].staticTexts["Failed To Log In"].exists)
    
  }

}
