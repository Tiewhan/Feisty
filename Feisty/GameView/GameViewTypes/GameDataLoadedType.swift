//
//  GameViewType.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/28.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import CommonFiles

/**
 The protocol that any view contoller should implement if it needs to react to data being successfully retrieved
 */
protocol GameDataLoadedType: AnyObject {
  
  func gameDataSuccessfullyLoaded(with data: [Game])
  
}
