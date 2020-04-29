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
    setupSnapshot(application)
    
    application.launchArguments += ["-UseStubs"]
    
  }
  
  func loginUser(with username: String, and password: String) {
    
    let usernameTextfield = application.textFields["loginUsernameTextfield"]
    let passwordTextfield = application.secureTextFields["loginPasswordTextfield"]
    
    usernameTextfield.tap()
    sleep(1)
    UIPasteboard.general.string = username
    usernameTextfield.tap()
    application.menuItems["Paste"].tap()
    
    passwordTextfield.tap()
    UIPasteboard.general.string = password
    passwordTextfield.doubleTap()
    application.menuItems["Paste"].tap()
    
    sleep(1)
    
    application.buttons["Login"].tap()
    
  }
  
}
