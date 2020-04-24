//
//  NSStringExtemsion.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/03/20.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

extension NSObject {
  
  var className: String {
    return String(describing: type(of: self)).components(separatedBy: ".").last!
  }
  
  class var className: String {
    return String(describing: self).components(separatedBy: ".").last!
  }
  
}
