//
//  GameViewTestCase.swift
//  FeistyUITests
//
//  Created by Tiewhan Smith on 2020/03/16.
//  Copyright © 2020 DVT. All rights reserved.
//

import XCTest

class GameViewTestCase: XCTestCase {
  
  var application: XCUIApplication!
  
  override func setUp() {
    
    continueAfterFailure = false
    
    application = XCUIApplication()
    setupSnapshot(application)
    
    application.launchArguments += ["-UseStubs"]
    
  }
  
  func loginUserWithDetails() {
    
    let usernameTextfield = application.textFields["loginUsernameTextfield"]
    let passwordTextfield = application.secureTextFields["loginPasswordTextfield"]
    
    usernameTextfield.tap()
    sleep(1)
    UIPasteboard.general.string = "tiewhan"
    usernameTextfield.tap()
    application.menuItems["Paste"].tap()
    
    passwordTextfield.tap()
    UIPasteboard.general.string = "cat3"
    passwordTextfield.doubleTap()
    application.menuItems["Paste"].tap()
    
    application.buttons["Login"].tap()
    
    sleep(2)
    
  }
  
}
