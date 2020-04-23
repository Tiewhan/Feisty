//
//  TableViewCell.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/04/03.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class BasicFriendCell: UITableViewCell {

  @IBOutlet weak var cellView: UIView!
  @IBOutlet weak var friendAvatar: UIImageView!
  @IBOutlet weak var username: UILabel!
  @IBOutlet weak var status: UILabel!
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    setUpCellDropShadow()
    friendAvatar.setUpCornerRadiusWith(radiusOf: 40)
      
  }
  
  private func setUpCellDropShadow() {
    
    cellView.layer.shadowColor = UIColor.black.cgColor
    cellView.layer.shadowOpacity = 0.25
    cellView.layer.shadowOffset = CGSize(width: 2, height: 2)
    cellView.layer.shadowRadius = 5
    
  }

}
