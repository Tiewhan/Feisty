//
//  LoginTestCase.swift
//  FeistyUITests
//
//  Created by Tiewhan Smith on 2020/03/13.
//  Copyright © 2020 DVT. All rights reserved.
//

import XCTest

class LoginTestCase: XCTestCase {
  
  var application: XCUIApplication!

  override func setUp() {
    
      continueAfterFailure = false

      application = XCUIApplication()
  }
  
  func loginUser(with username: String, and password: String) {
    
    application.textFields["Username"].tap()
    
    UIPasteboard.general.string = username
    application.textFields["Username"].doubleTap()
    application.menuItems["Paste"].tap()
    
    application.textFields["Password"].doubleTap()
    UIPasteboard.general.string = password
    application.textFields["Password"].tap()
    application.menuItems["Paste"].tap()
    
    application.buttons["Login"].tap()
    
  }
  
}
