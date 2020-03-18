//
//  GameViewTestCase.swift
//  FeistyUITests
//
//  Created by Tiewhan Smith on 2020/03/16.
//  Copyright © 2020 DVT. All rights reserved.
//

import XCTest
@testable import OHHTTPStubs

class GameViewTestCase: XCTestCase {
  
  var application: XCUIApplication!
  
  override func setUp() {
    
    continueAfterFailure = false
    
    application = XCUIApplication()
      }
  
  override func tearDown() {
    [HTTPStubs .removeAllStubs()]
  }
  
  func loginUserWithDetails() {
    
    application.textFields["Username"].tap()
    
    UIPasteboard.general.string = "tiewhan"
    application.textFields["Username"].doubleTap()
    application.menuItems["Paste"].tap()
    
    application.textFields["Password"].doubleTap()
    UIPasteboard.general.string = "cat3"
    application.textFields["Password"].tap()
    application.menuItems["Paste"].tap()
    
    application.buttons["Login"].tap()
    
    application.alerts["Login Message"].buttons["Dismiss"].tap()
    
    sleep(1)
    
  }
  
}
