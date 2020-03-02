//
//  GameTableViewCell.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/28.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

/// Represents an individual cell for the Game Table View
class GameTableViewCell: UITableViewCell {

  @IBOutlet weak var detailsStackView: UIStackView!
  @IBOutlet weak var txtViewGameName: UITextView!
  @IBOutlet weak var txtGamePrice: UILabel!

  private lazy var backGroundView: UIView = {
    let view = UIView()
    view.backgroundColor = .darkGray
    return view
  }()

  /**
   Pings the given view as a background to the given stackview
   
   - parameter view: The view that will be the background
   - parameter stackView: The stack that needs to have the background added to
   */
  private func pinBackGround(_ view: UIView, to stackView: UIStackView) {
    view.translatesAutoresizingMaskIntoConstraints = false
    stackView.insertSubview(view, at: 0)
    view.layer.cornerRadius = 10.0
    view.pin(to: stackView)
  }

  ///The cell equivalent of viewDidLoad
  override func layoutSubviews() {
    super.layoutSubviews()
    pinBackGround(backGroundView, to: detailsStackView)

  }

}

public extension UIView {

  /**
   All constraints of the given view are set equal to the corresponding anchors of this view
   */
  func pin(to view: UIView) {

    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: view.leadingAnchor),
      trailingAnchor.constraint(equalTo: view.trailingAnchor),
      topAnchor.constraint(equalTo: view.topAnchor),
      bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

  }

}
