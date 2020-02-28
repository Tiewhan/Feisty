//
//  GameViewModel.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/28.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import CommonFiles

///The class represents the data of the ViewModel and delegates work between the View and the Model
class GameDataViewModel {
  
  var observerID: String = "GameDataViewModelSubscriber"
  private weak var view: GameDataLoadedType?
  private var gameManager: GameManager?
  
  init(_ view: GameDataLoadedType) {
    self.view = view
  }
  
  /**
   Invoked by the view when the view has finished loading and can recieve data
   */
  func viewFinishedLoading() {
    
    let gameModel = GameModel()
    
    gameManager = gameModel.getGameManager()
    gameManager?.subscribeToGameManager(subscriber: self, subscriberID: observerID)
    
  }
  
  /**
   Gets the game that corresponds to the given index for use by the View.
   
   - Parameter index: The index of the game. This index matches the index of the row position on the view on not the data source
   
   - Returns: The game if found. Otherwise an empty game
   */
  func getGameAt(at index: Int) -> Game {
    
    if let game = gameManager?.gameList[index] {
      return game
    }
    
    return Game(appid: "0", name: "Empty Game")
  }
  
}

///Extends the View Model with the GameManagerObserver to react to games finished being loaded
extension GameDataViewModel: GameManagerObserver {
  
  func gamesFinishedLoading() {
    
    if let gameList = gameManager?.gameList {
      view?.gameDataSuccessfullyLoaded(with: gameList)
    }
    
  }
  
}
