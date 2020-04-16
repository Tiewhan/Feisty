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

  @IBOutlet weak var gameNameLabel: UILabel!
  @IBOutlet weak var lblPrice: UILabel!
  @IBOutlet weak var lblShortDescription: UITextView!
  @IBOutlet weak var lblDevelopers: UITextView!
  @IBOutlet weak var lblPublishers: UITextView!
  @IBOutlet weak var gameCard: UIView!
  
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
    setUpGameCardDropShadow()
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
  
  private func setUpGameCardDropShadow() {
    
    gameCard.layer.shadowColor = UIColor.black.cgColor
    gameCard.layer.shadowOpacity = 0.25
    gameCard.layer.shadowOffset = CGSize(width: 4, height: 4)
    gameCard.layer.shadowRadius = 10
    
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
