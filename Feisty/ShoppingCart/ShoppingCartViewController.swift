//
//  ShoppingCartViewController.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/04/16.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit
import CommonFiles
import CoreData

class ShoppingCartViewController: UIViewController {
  
  @IBOutlet weak var checkoutButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  
  var shoppingCart: ShoppingCart?
  
  private lazy var viewModel: ShoppingCartViewModelType = {
    
    let viewModel = ShoppingCartViewModel()
    var model = ShoppingCartModel(withShoppingCart: shoppingCart)
    
    if let coreDataAppDelete = UIApplication.shared.delegate as? CoreDataAppDelegate {
      
      let repo = ShoppingCartCoreDataRepo(withAppDelegate: coreDataAppDelete)
      model.coreDataRepo = repo
      repo.subscribeToRepository(withObserver: model)
      
    }
    
    viewModel.model = model
    model.subscribeToModel(withObserver: viewModel)
    viewModel.view = self
    
    return viewModel
    
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpTableView()
    
    checkoutButton.setUpDropShadow()
    checkoutButton.setUpCornerRadiusWith(radiusOf: 25)
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    viewModel.saveShoppingCart()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    viewModel.loadShoppingCart()
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
        viewModel.removeItem(at: indexPath.row)
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
    cell.gameImage.image = gameDetails.headerImage ?? #imageLiteral(resourceName: "Default Game Icon")
    
    return cell
    
  }
  
}

extension ShoppingCartViewController: ShoppingCartViewType {
  
  func gamesInCartLoaded() {
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
    
  }
  
}
