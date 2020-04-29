//
//  FriendViewUITests.swift
//  FeistyUITests
//
//  Created by Tiewhan Smith on 2020/03/19.
//  Copyright © 2020 DVT. All rights reserved.
//

import XCTest

class FriendViewUITests: FriendViewTestCase {
  
  func testFriendListLoad() {
    
    application.launch()
    
    loginUserWithDetails()
    
    application.tabBars.buttons["Friends"].tap()
    
    XCTAssert(application.staticTexts["Urod"].exists)
    
    snapshot("Friends01")
    
  }
  
  func testLoadFriendsThenGoToGamesThenBackToFriends() {
    
    application.launch()
    
    loginUserWithDetails()
    
    application.tabBars.buttons["Friends"].tap()
    XCTAssert(application.staticTexts["Urod"].exists)
    
    application.tabBars.buttons["Games"].tap()
    XCTAssert(application.staticTexts["A Day For A Kitten"].exists)
    
    application.tabBars.buttons["Friends"].tap()
    XCTAssert(application.staticTexts["Kelly"].exists)
    
  }
  
}
