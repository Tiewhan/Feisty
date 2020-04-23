//
//  GamesViewController.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/06.
//  Copyright © 2020 DVT. All rights reserved.
//
import UIKit
import CommonFiles

// MARK: Controllers
class GamesViewController: UITableViewController {

  // MARK: Properties and Outlets
  private lazy var dataViewModel: GameDataViewModel = {
    return GameDataViewModel(self, with: GameModel(GameAPIRepo(),
                                                   andImageRepo: GameImageAPIRepo()))
  }()
  
  var shoppingCart: ShoppingCart = ShoppingCart()
  
  @IBOutlet var mainView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpActivityInidcator()

  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return dataViewModel.getPageCount()
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
      as? GameTableViewCell else {
      return UITableViewCell()
    }

    let gameDetails = dataViewModel.getGameDetails(at: indexPath.row)
    cell.txtViewGameName?.text = gameDetails.gameName
    cell.txtGamePrice?.text = gameDetails.gamePrice
    cell.headerImage?.image = gameDetails.gameHeader ?? #imageLiteral(resourceName: "Default Game Icon")
    
    cell.cellTappedAction = { [weak self] in
      
      let storyboard = UIStoryboard(name: "Main", bundle: .main)
      let className = GameDetailsViewController.className
      let detailView = storyboard.instantiateViewController(withIdentifier: className) as? GameDetailsViewController
      
      guard let detailViewController = detailView else {
        return
      }
      
      guard let self = self else {
        return
      }
      
      let selectedGame = self.dataViewModel.getGameAt(at: indexPath.row)
      detailViewController.selectedGame = selectedGame
      detailViewController.shoppingCart = self.shoppingCart
      
      self.navigationController?.pushViewController(detailViewController, animated: true)
    }

    return cell

  }

  /**
   Sets the constraints and settings needed by the activity indicator to start. Will also
   start the animation of the activity indicator
   */
  private func setUpActivityInidcator() {

    guard let activityIndicator = self.activityIndicator else {
      return
    }

    let horizontalConstraint = NSLayoutConstraint(item: activityIndicator,
                                                  attribute: NSLayoutConstraint.Attribute.centerX,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: mainView,
                                                  attribute: NSLayoutConstraint.Attribute.centerX,
                                                  multiplier: 1,
                                                  constant: 0)
    mainView.addConstraint(horizontalConstraint)
    let verticalConstraint = NSLayoutConstraint(item: activityIndicator,
                                                attribute: NSLayoutConstraint.Attribute.centerY,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: mainView,
                                                attribute: NSLayoutConstraint.Attribute.centerY,
                                                multiplier: 1,
                                                constant: 0)
    mainView.addConstraint(verticalConstraint)

    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.hidesWhenStopped = true
    activityIndicator.startAnimating()

  }
  
  /**
   Stops to the activity indicator on the main thread by async
   */
  private func stopActivityIndicator() {
    
    DispatchQueue.main.async { [weak self] in
      self?.activityIndicator.stopAnimating()
    }
    
  }
  
  /**
   Reload the table data on the main thread by synced
   */
  private func reloadTableData() {
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }
  }

}

/**
 Extend the ViewController with the GameDataLoadedType from the MVVC architecture
 */
extension GamesViewController: GameDataLoadedType {
  
  func headerImageLoadedForGame(at index: Int, withImage image: UIImage?) {
    
    DispatchQueue.main.async {
      
      let indexPath = IndexPath(row: index, section: 0)
      let cell = self.mainView.cellForRow(at: indexPath) as? GameTableViewCell
      
      cell?.headerImage.image = image
      
    }
    
  }
  
  /**
   When the View Model finished loading the data this function will be invoked
   
   - Parameter data: The data that was retrieved from the View Model
   */
  func gameDataSuccessfullyLoaded(with data: [Game]) {
    
    stopActivityIndicator()
    reloadTableData()
  
  }
  
}
