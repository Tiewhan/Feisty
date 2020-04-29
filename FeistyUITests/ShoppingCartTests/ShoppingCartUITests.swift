//
//  ShoppingCartUITests.swift
//  FeistyUITests
//
//  Created by Tiewhan Smith on 2020/04/29.
//  Copyright © 2020 DVT. All rights reserved.
//

import XCTest

class ShoppingCartUITests: ShoppingCartViewTestCase {
  
  func testAddGameToCartThenRemoveGameFromCart() {
    
    application.launch()
    
    loginUserWithDetails()
    
    application.staticTexts["Astebreed - Original Soundtrack"].tap()
    application.buttons["addToCartFAB"].tap()
    application.buttons["shoppingCartFAB"].tap()
    
    XCTAssert(application.staticTexts["Astebreed - Original Soundtrack"].exists)
    
  }
  
  func testAddTwoGamesToCartThenRemoveBothFromCart() {
    
    application.launch()
    
    loginUserWithDetails()
    
    application.staticTexts["Astebreed - Original Soundtrack"].tap()
    application.buttons["addToCartFAB"].tap()
    application.navigationBars.buttons["Games"].tap()
    application.staticTexts["A Day For A Kitten"].tap()
    application.buttons["addToCartFAB"].tap()
    application.buttons["shoppingCartFAB"].tap()
    
    XCTAssert(application.staticTexts["Astebreed - Original Soundtrack"].exists)
    XCTAssert(application.staticTexts["A Day For A Kitten"].exists)
    
  }
  
  func testRemoveGameFromCart() {
    
    application.launch()
    
    loginUserWithDetails()
    
    application.staticTexts["Astebreed - Original Soundtrack"].tap()
    application.buttons["addToCartFAB"].tap()
    application.navigationBars.buttons["Games"].tap()
    application.staticTexts["A Day For A Kitten"].tap()
    application.buttons["addToCartFAB"].tap()
    application.buttons["shoppingCartFAB"].tap()
    
    XCTAssert(application.staticTexts["Astebreed - Original Soundtrack"].exists)
    
    swipeLeftToDelete()
    
    XCTAssert(application.staticTexts["A Day For A Kitten"].exists)
    
  }
  
}
