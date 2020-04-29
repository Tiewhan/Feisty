//
//  GameViewUITests.swift
//  FeistyUITests
//
//  Created by Tiewhan Smith on 2020/03/16.
//  Copyright © 2020 DVT. All rights reserved.
//

import XCTest
@testable import Feisty
@testable import CommonFiles

class GameViewUITests: GameViewTestCase {

  func testLoadGames() {
    
    application.launch()

    loginUserWithDetails()

    XCTAssert(application.staticTexts["test2"].exists)
    snapshot("GameStore01")
    
  }
  
  func testLoadGameDetailsThenBack() {
    
    application.launch()

    loginUserWithDetails()

    application.staticTexts["test2"].tap()
    XCTAssert(application.staticTexts["test2"].exists)
    
    application.navigationBars.buttons["Games"].tap()
    XCTAssert(application.staticTexts["Games"].exists)

  }
  
  func testScrollDownAndSelectGame() {
    
    application.launch()
    
    loginUserWithDetails()
    
    application.swipeUp()
    
    XCTAssert(application.staticTexts["Lantern of Worlds - The Story of Samir"].exists)
    application.staticTexts["Lantern of Worlds - The Story of Samir"].tap()
    
    XCTAssert(application.staticTexts["Game Details"].exists)
    
  }
  
}
