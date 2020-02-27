//
//  LoginModel.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/27.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class LoginModel {
  
  func attemptLogin(with username: String, and password: String) -> Bool {
    
    return username == "tiewhan" && password == "cat3"
    
  }
  
}
