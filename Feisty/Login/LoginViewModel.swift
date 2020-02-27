//
//  LoginViewModel.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/27.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

class LoginViewModel {
  
  private weak var view: LoginType?
  
  init(withView view: LoginType) {
    self.view = view
  }
  
  func attemptLogin(with userName: String, and password: String) {
    
    let model = LoginModel()
    
    let loggedIn = model.attemptLogin(with: userName, and: password)
    
    if loggedIn {
      view?.authenticationSuccess()
    } else {
      view?.authenticationFailure()
    }
    
  }
  
}
