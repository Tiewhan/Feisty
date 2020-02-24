//
//  GameManager.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/06.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import CommonFiles

class GameManager {

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

  /**
   Allows class and structs that confrom to the GameManagerObserver protocol to react to
   certain events triggered by the manager
   
   - Parameter observer: The class/struct that conforms to the GameManagerObserver protocol
   - Parameter observerID: The unique ID that is needed to identify the observer
   */
    func subscribeToGameManager(subscriber observer: GameManagerObserver,
                                        subscriberID observerID: String) -> Void {
      observers[observerID] = observer
    }

  /**
   Removes a class/struct from the list of subsrcibers that get notified about GameManager events
   
   - Parameter observerID: The ID of the observer to remove from the list
   */
    func unsubscribeFromGameManager(subscriberID observerID: String) -> Void {
      observers.removeValue(forKey: observerID)
    }

  /**
   Iterates through of the GameManagerOservers and notifies all of them about an event.
   */
    private func notifyAllObservers() -> Void{
      observers.forEach({ (observer) in
        observer.value.gamesFinishedLoading()
      })
    }

}
