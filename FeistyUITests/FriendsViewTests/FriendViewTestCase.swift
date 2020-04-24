//
//  FriendViewTestCase.swift
//  FeistyUITests
//
//  Created by Tiewhan Smith on 2020/03/19.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import XCTest
@testable import Feisty
@testable import CommonFiles

class FriendViewTestCase: XCTestCase {
  
  var application: XCUIApplication!
  
  override func setUp() {
    
    continueAfterFailure = false
    
    application = XCUIApplication()
    setupSnapshot(application)
    
    application.launchArguments += ["-UseStubs", "true"]
    
  }
  
  func loginUserWithDetails() {
    
    application.textFields["Username"].tap()
    sleep(1)
    UIPasteboard.general.string = "tiewhan"
    application.textFields["Username"].tap()
    application.menuItems["Paste"].tap()
    
    application.textFields["Password"].doubleTap()
    UIPasteboard.general.string = "cat3"
    application.textFields["Password"].tap()
    application.menuItems["Paste"].tap()
    
    sleep(1)
    
    application.buttons["Login"].tap()
    
    application.alerts["Login Message"].buttons["Dismiss"].tap()
    
    sleep(1)
    
  }
  
}
