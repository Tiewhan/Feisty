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
  @IBOutlet weak var shoppingCartFAB: FloatingActionButton!
  @IBOutlet weak var addToCartFAB: FloatingActionButton!
  @IBOutlet weak var shoppingCartRightConstraint: NSLayoutConstraint!
  @IBOutlet weak var imageView: UIImageView!
  
  var selectedGame: Game?
  var shoppingCart: ShoppingCart?
  
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
    
    setUpShoppingCartFloatingActionButton()
    setUpAddToCartFloatingActionButton()
    
  }
  
  private func setUpShoppingCartFloatingActionButton() {
    
    shoppingCartFAB.backgroundColor = UIColor.clear
    shoppingCartFAB.button.setImage(#imageLiteral(resourceName: "ShoppingCart"), for: .normal)
    shoppingCartFAB.actionToPerform = {
      
      let storyboard = UIStoryboard(name: "Main", bundle: .main)
      let className = ShoppingCartViewController.className
      let shoppingModal = storyboard.instantiateViewController(withIdentifier: className) as? ShoppingCartViewController
      
      guard let shoppingCartViewController = shoppingModal else {
        return
      }
      
      shoppingCartViewController.shoppingCart = self.shoppingCart
      
      self.present(shoppingCartViewController, animated: true, completion: nil)
    }
    
  }
  
  private func setUpAddToCartFloatingActionButton() {
    
    addToCartFAB.backgroundColor = UIColor.clear
    addToCartFAB.actionToPerform = { [weak self] in
      
      guard let self = self, let game = self.selectedGame else {
        return
      }
      
      self.shoppingCart?.shoppingList.append(game)
      
      self.shoppingCartRightConstraint.constant = 32
      
      let animations: () -> Void = { [weak self] in
        self?.view.layoutIfNeeded()
      }
      
      let completion: (Bool) -> Void = { [weak self] _ in
        
        self?.shoppingCartRightConstraint.constant = 16
        
        UIView.animate(withDuration: 0.25, animations: animations)
        
      }
      
      UIView.animate(withDuration: 0.25, animations: animations, completion: completion)
      
    }
    
  }
  
  private func setGameDetails(with gameName: String,
                              andAppID appID: String,
                              andPrice price: String,
                              andShortDescription shortDescription: String,
                              andDevelopers developers: String,
                              andPublishers publishers: String,
                              andHeaderImage headerImage: UIImage?) {

    gameNameLabel.text = gameName
    lblPrice.text = price
    lblShortDescription.text = shortDescription
    lblDevelopers.text = developers
    lblPublishers.text = publishers
    imageView.image = headerImage ?? #imageLiteral(resourceName: "Default Game Icon")

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
                        _ publishers: String,
                        _ headerImage: UIImage?) {
    
    setGameDetails(with: withGameName,
                   andAppID: andAppID,
                   andPrice: price,
                   andShortDescription: shortDescription,
                   andDevelopers: developers,
                   andPublishers: publishers,
                   andHeaderImage: headerImage)
    
  }
  
}
