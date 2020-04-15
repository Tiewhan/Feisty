//
//  UIViewExtensions.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/04/15.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  
  func setUpDropShadow(colour: CGColor = UIColor.black.cgColor,
                       opacity: Float = 0.25,
                       shadowOffset: CGSize = CGSize(width: 4, height: 4),
                       shadowRadius: CGFloat = 4 ) {
    
    self.layer.shadowColor = colour
    self.layer.shadowOpacity = opacity
    self.layer.shadowOffset = shadowOffset
    self.layer.shadowRadius = shadowRadius
    
  }

  func setUpCornerRadiusWith(radiusOf radius: CGFloat) {
    self.layer.cornerRadius = radius
  }
  
}

