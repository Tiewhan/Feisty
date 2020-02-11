//
//  GameManager.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/06.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class GameManager{
    
    var gameList: [Game] = []
    var observers: [String: GameManagerObserver] = [:]
    
    init() {
        
      let apiManager: APIManager = APIManager()
      
      apiManager.getGames { (games) in
          
        var smallGameList: [Game] = []
        
        //This limit exists until sectioning with the table works.
        let size: Int = games.count >= 25 ? 25 : games.count
        
        if games.count >= 1 {
            
          for index in 0...(size - 1) {
              smallGameList.append(games[index])
          }
          
          self.gameList = smallGameList
          self.notifyAllObservers()
            
        }
          
      }
        
    }
    
    func subscribeToGameManagerObserver(subscriber observer: GameManagerObserver, subscriberID observerID: String) {
      observers[observerID] = observer
    }
    
    func unsubscribeFromGameManagerObserver(subscriber observer: GameManagerObserver, subscriberID observerID: String){
      observers.removeValue(forKey: observerID)
    }
    
    func notifyAllObservers() {
      observers.forEach({ (observer) in
        observer.value.gamesFinishedLoading()
      })
    }

}
