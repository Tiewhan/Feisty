//
//  GameManager.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/06.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class GameManager{
    
    private var gameList: [Game] = []
    
    var GameList: [Game]{
        get { return gameList }
    }
    
    init() {
        
        
        gameList.append(Game(gameName: Name("Monster Hunter: World"), gamePrice: Money(1000.00)))
        gameList.append(Game(gameName: Name("The Sims 4"), gamePrice: Money(600.00)))
        gameList.append(Game(gameName: Name("The Sims 3"), gamePrice: Money(600.00)))
        gameList.append(Game(gameName: Name("DoTA"), gamePrice: Money(0)))
        
    }
    
}
