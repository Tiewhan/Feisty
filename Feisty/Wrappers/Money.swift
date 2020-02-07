//
//  Money.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/06.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class Money{
    
    private var amount: Double
    
    var Amount: Double{
        get { return amount }
        set { amount = newValue }
    }
    
    init(_ amount: Double) {
        self.amount = amount
    }
    
    init(_ amount: Int) {
        self.amount = Double(amount)
    }
    
}
