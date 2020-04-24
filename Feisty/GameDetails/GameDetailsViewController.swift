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
    
    let game = selectedGame ?? Game.defaultValue
    return GameDetailsViewModel(self, game)
    
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.getGameData()
    gameCard.setUpDropShadow(shadowRadius: 10)
    
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
      self.animateShoppingCart()
    }
    
  }
  
  private func animateShoppingCart() {
    
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
  
  private func setGameDetails(gameDTO: GameDataTransferObject) {

    gameNameLabel.text = gameDTO.name
    lblPrice.text = gameDTO.price
    lblShortDescription.text = gameDTO.shortDescription
    lblDevelopers.text = gameDTO.developers[0]
    lblPublishers.text = gameDTO.publishers[0]
    imageView.image = gameDTO.headerImage ?? #imageLiteral(resourceName: "Default Game Icon")

  }
  
}

extension GameDetailsViewController: GameDetailsLoadedType {
  
  func gameDetailsFound(_ gameDTO: GameDataTransferObject) {
    setGameDetails(gameDTO: gameDTO)
  }
  
}
