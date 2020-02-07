//
//  Game.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/06.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class Game {
    
    private var name: Name
    private var price: Money
    
    var GameName: Name{
        get { return name }
        set { name = newValue }
    }
    
    var Price: Money{
        get { return price }
        set { price = newValue }
    }
    
    init(gameName name: Name, gamePrice price:Money) {
        
        self.name = name
        self.price = price
        
    }
    
    func toString() -> String{
        return name.Text
    }
    
}
