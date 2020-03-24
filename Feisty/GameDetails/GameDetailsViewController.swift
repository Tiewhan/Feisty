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
  @IBOutlet weak var lblPrice: UITextView!
  @IBOutlet weak var lblShortDescription: UITextView!
  @IBOutlet weak var lblDevelopers: UITextView!
  @IBOutlet weak var lblPublishers: UITextView!
  
  internal var selectedGame: Game?
  
  private lazy var viewModel: GameDetailsViewModel = {
    
    if let selectedGame = selectedGame {
      return GameDetailsViewModel(self, selectedGame)
    } else {
      return GameDetailsViewModel(self, Game.defaultValue)
    }
    
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.getGameData()
  }
  
  private func setGameDetails(with gameName: String,
                              andAppID appID: String,
                              andPrice price: String,
                              andShortDescription shortDescription: String,
                              andDevelopers developers: String,
                              andPublishers publishers: String) {

    gameNameLabel.text = gameName
    lblPrice.text = price
    lblShortDescription.text = shortDescription
    lblDevelopers.text = developers
    lblPublishers.text = publishers

  }
  
}

extension GameDetailsViewController: GameDetailsLoadedType {
  
  func gameDetailsFound(_ withGameName: String,
                        _ andAppID: String,
                        _ price: String,
                        _ shortDescription: String,
                        _ developers: String,
                        _ publishers: String) {
    
    setGameDetails(with: withGameName,
                   andAppID: andAppID,
                   andPrice: price,
                   andShortDescription: shortDescription,
                   andDevelopers: developers,
                   andPublishers: publishers)
    
  }
  
}
