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
    
    if let selectedGame = selectedGame {
      return GameDetailsViewModel(self, selectedGame)
    } else {
      return GameDetailsViewModel(self, Game(appid: "N/A", name: "No Game"))
    }
    
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.getGameData()
  }

  private func setGameDetails(name: String, appID: String) {

    gameNameLabel.text = name
    lblAppID.text = appID

  }

}

extension GameDetailsViewController: GameDetailsLoadedType {
  
  func gameDetailsFound(_ withGameName: String, _ andAppID: String) {
    setGameDetails(name: withGameName, appID: andAppID)
  }
  
}
