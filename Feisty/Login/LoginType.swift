//
//  LoginType.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/27.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

protocol LoginType: AnyObject {
  
  func authenticationSuccess()
  
  func authenticationFailure()
  
}
