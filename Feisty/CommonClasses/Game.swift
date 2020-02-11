//
//  Game.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/06.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class Game: Codable {
    
    var appID: String
    var name: String
    var price: Double = 0.00
    
    init(gameName name: String, gamePrice price: Double) {
        
        self.name = name
        self.price = price
        appID = ""
        
    }
    
    init(_ jsonDecodedGame: JsonGame) {
        
        appID = "\(jsonDecodedGame.appid)"
        name = jsonDecodedGame.name
        
    }
    
    func toString() -> String {
        return name
    }
    
}
