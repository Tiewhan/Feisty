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
    
    let listItem = application.staticTexts["test2"]
    let exsists = NSPredicate(format: "exists == 1")
    
    expectation(for: exsists, evaluatedWith: listItem, handler: nil)
    waitForExpectations(timeout: 20, handler: nil)
    
  }
  
  func testLoadGameDetailsThenBack() {
    
    application.launch()
    
    loginUserWithDetails()
    
    let gameNameLabel = application.staticTexts["test2"]
    let exists = NSPredicate(format: "exists == 1")
    
    expectation(for: exists, evaluatedWith: gameNameLabel, handler: nil)
    waitForExpectations(timeout: 20) { [weak self] (error) in
      
      guard error == nil else {
        return
      }
      
      self?.application.staticTexts["test2"].tap()
      sleep(1)
      XCTAssert(self?.application.staticTexts["test2"].exists ?? false)
      
      self?.application.navigationBars.buttons["Games"].tap()
      XCTAssert(self?.application.staticTexts["Games In Store"].exists ?? false)
      
    }
    
  }
  
}
