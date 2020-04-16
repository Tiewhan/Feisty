//
//  ShoppingCartViewController.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/04/16.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {
  
  @IBOutlet weak var checkoutButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    checkoutButton.setUpDropShadow()
    checkoutButton.setUpCornerRadiusWith(radiusOf: 25)
    
  }
    
}
