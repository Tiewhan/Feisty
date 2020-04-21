//
//  ShoppingCartViewController.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/04/16.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit
import CommonFiles

class ShoppingCartViewController: UIViewController {
  
  @IBOutlet weak var checkoutButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  
  var shoppingCart: ShoppingCart?
  private lazy var viewModel: ShoppingCartViewModelType = {
    
    let viewModel = ShoppingCartViewModel()
    
    viewModel.model = ShoppingCartModel(shoppingCart: shoppingCart ?? ShoppingCart())
    
    return viewModel
    
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpTableView()
    
    checkoutButton.setUpDropShadow()
    checkoutButton.setUpCornerRadiusWith(radiusOf: 25)
    
  }
  
  private func setUpTableView() {
    
    tableView.delegate = self
    tableView.dataSource = self
    
  }
    
}

extension ShoppingCartViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return true
  }

  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    
      if editingStyle == .delete {
        let index = indexPath.row
        shoppingCart?.shoppingList.remove(at: index)
        tableView.reloadData()
      }
    
  }
  
  func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
    return "Remove From Cart"
  }
  
}

extension ShoppingCartViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getAmountInCart()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartGameCell", for: indexPath)
      as? ShoppingCartTableCell else {
      return UITableViewCell()
    }
    
    let gameDetails = viewModel.getGame(at: indexPath.row)
    cell.txtGamePrice.text = gameDetails.price
    cell.txtViewGameName.text = gameDetails.name
    
    return cell
    
  }
  
}
