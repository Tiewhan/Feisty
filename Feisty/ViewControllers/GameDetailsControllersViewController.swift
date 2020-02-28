//
//  GameDetailsController.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/18.
//  Copyright © 2020 DVT. All rights reserved.
//
import UIKit
import CommonFiles

class GameDetailsController: UIViewController {

  @IBOutlet weak var gameNameLabel: UITextView!
  @IBOutlet weak var lblAppID: UITextView!

  internal var selectedGame: Game?

  override func viewDidLoad() {
    super.viewDidLoad()

    setGameDetails()

  }

  private func setGameDetails() {

    if let selectedGame = selectedGame {
      gameNameLabel.text = selectedGame.name
      lblAppID.text = selectedGame.appID
    }

  }

}
