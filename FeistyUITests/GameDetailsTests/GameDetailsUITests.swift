//
//  GameDetailsUITests.swift
//  FeistyUITests
//
//  Created by Tiewhan Smith on 2020/04/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import XCTest

class GameDetailsUITests: GameDetailsViewTestCase {
  
  func testDetailsLoaded() {
    
    application.launch()
    
    loginUserWithDetails()
    
    application.staticTexts["Astebreed - Original Soundtrack"].tap()
    
    XCTAssert(application.staticTexts["Astebreed - Original Soundtrack"].exists)
    
    snapshot("GameDetails01")
    
  }
  
  func testGivenProperLoadedGameWhenScrolledDownThenPublisherIsShown() {
    
    application.launch()
    
    loginUserWithDetails()
    
    application.swipeUp()
    application.staticTexts["Lantern of Worlds - The Story of Samir"].tap()
    snapshot("GameDetails02")
    
    XCTAssert(application.staticTexts["Lantern of Worlds - The Story of Samir"].exists)
    
    application.swipeUp()
    
    XCTAssert(application.staticTexts["Blizzard"].exists)
    
    snapshot("GameDetails03")
    
  }
  
  func testMoveToDifferentGameDetailsFromDetails() {
    
    application.launch()
    
    loginUserWithDetails()
    
    application.staticTexts["Astebreed - Original Soundtrack"].tap()
    
    XCTAssert(application.staticTexts["Astebreed - Original Soundtrack"].exists)
    
    application.navigationBars.buttons["Games"].tap()
    application.swipeUp()
    application.staticTexts["Waste Walkers Survivor Pack DLC"].tap()
    
    XCTAssert(application.staticTexts["Waste Walkers Survivor Pack DLC"].exists)
    
    snapshot("GameDetails04")
    
  }
  
  func testSameDetailsAfterGoingToFriends() {
    
    application.launch()
    
    loginUserWithDetails()
    
    application.staticTexts["Astebreed - Original Soundtrack"].tap()
    
    XCTAssert(application.staticTexts["Astebreed - Original Soundtrack"].exists)
    
    application.tabBars.buttons["Friends"].tap()
    
    XCTAssert(application.staticTexts["Kelly"].exists)
    
    application.tabBars.buttons["Games"].tap()
    
    XCTAssert(application.staticTexts["Astebreed - Original Soundtrack"].exists)
    
  }
  
}
