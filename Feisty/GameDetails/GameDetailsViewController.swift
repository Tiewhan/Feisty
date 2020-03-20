//
//  GameDetailsController.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/18.
//  Copyright © 2020 DVT. All rights reserved.
//
import UIKit
import CommonFiles

class GameDetailsViewController: UIViewController {

  @IBOutlet weak var gameNameLabel: UITextView!
  @IBOutlet weak var lblAppID: UITextView!
  
  internal var selectedGame: Game?
  
  private lazy var viewModel: GameDetailsViewModel = {
    return GameDetailsViewModel(self, game: selectedGame)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.getGameData()

  }

  private func setGameDetails(name: String, appID: String) {

    if let selectedGame = selectedGame {
      gameNameLabel.text = selectedGame.name
      lblAppID.text = selectedGame.appID
    }

  }

}

extension GameDetailsViewController: GameDetailsLoadedType {
  
  func gameDetailsFound(gameDetails: (gameName: String, appID: String)) {
    
    setGameDetails(name: gameDetails.gameName, appID: gameDetails.appID)
    
  }

}
