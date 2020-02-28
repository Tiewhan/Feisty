//
//  GameViewModel.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/28.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import CommonFiles

class GameDataViewModel {
  
  var observerID: String = "GameDataViewModelSubscriber"
  private weak var view: GameDataLoadedType?
  private var gameManager: GameManager?
  
  init(_ view: GameDataLoadedType) {
    self.view = view
  }
  
  func viewFinishedLoading() {
    
    let gameModel = GameModel()
    
    gameManager = gameModel.getGameManager()
    gameManager?.subscribeToGameManager(subscriber: self, subscriberID: observerID)
    
  }
  
  func getGameAt(at index: Int) -> Game {
    
    if let game = gameManager?.gameList[index] {
      return game
    }
    
    return Game(appid: "0", name: "Empty Game")
  }
  
}

extension GameDataViewModel: GameManagerObserver {
  
  func gamesFinishedLoading() {
    
    if let gameList = gameManager?.gameList {
      view?.gameDataSuccessfullyLoaded(with: gameList)
    }
    
  }
  
}
