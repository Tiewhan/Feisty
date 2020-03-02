//
//  GameDetailsLoadedType.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/03/02.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
protocol  GameDetailsLoadedType: AnyObject {
  func gameDetailsFound(gameDetails: (gameName: String, appID: String))
}
