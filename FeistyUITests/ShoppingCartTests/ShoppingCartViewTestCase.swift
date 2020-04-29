//
//  ShoppingCartViewTestCase.swift
//  FeistyUITests
//
//  Created by Tiewhan Smith on 2020/04/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import XCTest
@testable import Feisty
@testable import CommonFiles

class ShoppingCartViewTestCase: XCTestCase {

  var application: XCUIApplication!
  
  override func setUp() {
    
    continueAfterFailure = false
    
    application = XCUIApplication()
    setupSnapshot(application)
    
    application.launchArguments += ["-UseStubs", "true"]
    
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
    
    sleep(1)
    
  }
  
  func swipeLeftToDelete() {
    
    let cell = application.cells.element(boundBy: 0) // first cell on the page

    let rightOffset = CGVector(dx: 0.95, dy: 0.5)
    let leftOffset = CGVector(dx: 0.05, dy: 0.5)

    let cellFarRightCoordinate = cell.coordinate(withNormalizedOffset: rightOffset)
    let cellFarLeftCoordinate = cell.coordinate(withNormalizedOffset: leftOffset)

    // drag from right to left to delete
    cellFarRightCoordinate.press(forDuration: 0.1, thenDragTo: cellFarLeftCoordinate)
    
  }
  
}
