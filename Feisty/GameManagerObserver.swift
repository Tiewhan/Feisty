//
//  GameManagerObserver.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/10.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

protocol GameManagerObserver {
    var observerID: String { get set }
    func gamesFinishedLoading()
}
