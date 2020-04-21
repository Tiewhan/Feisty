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
  public var cellTappedAction: (() -> Void)?

  private lazy var backGroundView: UIView = {
    let view = UIView()
    view.backgroundColor = .darkGray
    return view
  }()

  ///The cell equivalent of viewDidLoad
  public override func layoutSubviews() {
    super.layoutSubviews()
    
    setUpCellDropShadow()
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
  
  private func setUpCellDropShadow() {
    
    cellView.layer.shadowColor = UIColor.black.cgColor
    cellView.layer.shadowOpacity = 0.25
    cellView.layer.shadowOffset = CGSize(width: 2, height: 2)
    cellView.layer.shadowRadius = 5
    
  }

}
