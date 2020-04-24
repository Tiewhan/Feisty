//
//  GameTableViewCell.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/28.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

/// Represents an individual cell for the Game Table View
public class GameTableViewCell: UITableViewCell {

  @IBOutlet weak var headerImage: UIImageView!
  @IBOutlet weak var cellView: UIView!
  @IBOutlet weak var txtViewGameName: UILabel!
  @IBOutlet public weak var txtGamePrice: UILabel!
  @IBOutlet weak var gameImage: UIImageView!
  public var cellTappedAction: (() -> Void)?

  ///The cell equivalent of viewDidLoad
  public override func layoutSubviews() {
    super.layoutSubviews()
    
    cellView.setUpDropShadow(shadowOffset: CGSize(width: 2, height: 2), shadowRadius: 5)
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
