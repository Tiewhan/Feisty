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
  public var cellTappedAction: (() -> Void)?
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    cellView.setUpDropShadow(shadowOffset: CGSize(width: 2, height: 2), shadowRadius: 5)
    friendAvatar.setUpCornerRadiusWith(radiusOf: 40)
    
    setUpTapGestureRecognizer()
      
  }
  
  private func setUpTapGestureRecognizer() {
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    
    tapGesture.delegate = self
    self.addGestureRecognizer(tapGesture)
    
  }
  
  @IBAction private func handleTap(sender: UITapGestureRecognizer) {
    
    guard let cellTappedAction = cellTappedAction else {
      return
    }
    
    cellTappedAction()
    
  }
  
}
