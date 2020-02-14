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
    var observers: Dictionary<String, GameManagerObserver> = [:]
    
    init(){
        
//        gameList.append(Game(gameName: "Monster Hunter: World", gamePrice: 1000.00))
//        gameList.append(Game(gameName: "The Sims 4", gamePrice: 600.00))
//        gameList.append(Game(gameName: "The Sims 3", gamePrice: 600.00))
//        gameList.append(Game(gameName: "DoTA", gamePrice: 0))
        
        let apiManager: ApiManager = ApiManager()
        
        apiManager.getGames(){ (games) in
            
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
    
    func subscribeToGameManagerObserver(subscriber observer: GameManagerObserver, subscriberID observerID: String){
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
