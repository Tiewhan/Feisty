//
//  ShoppingCartTableCell.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/04/17.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import UIKit

public class ShoppingCartTableCell: UITableViewCell {

  @IBOutlet weak var cellView: UIView!
  @IBOutlet weak var txtViewGameName: UILabel!
  @IBOutlet weak var txtGamePrice: UILabel!
  @IBOutlet weak var gameImage: UIImageView!
  
  ///The cell equivalent of viewDidLoad
  public override func layoutSubviews() {
    super.layoutSubviews()
    
    cellView.setUpDropShadow(shadowOffset: CGSize(width: 2, height: 2), shadowRadius: 5)

  }
  
}
