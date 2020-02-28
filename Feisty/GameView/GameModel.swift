//
//  GameModel.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/28.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

///The GameModel class retrieves data when asked by the View Model
class GameModel {
  
  func getGameManager() -> GameManager {
    return GameManager()
  }
  
}
