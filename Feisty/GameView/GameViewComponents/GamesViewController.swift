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
    return GameDataViewModel(self)
  }()
  
  private lazy var tableDataSource: [Game] = {
    return []
  }()
  
  @IBOutlet var mainView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  override func viewDidLoad() {
    super.viewDidLoad()

    dataViewModel.viewFinishedLoading()

    setUpActivityInidcator()

  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return tableDataSource.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
      as? GameTableViewCell else {
      return UITableViewCell()
    }

    let game: Game = tableDataSource[indexPath.row]
    cell.txtViewGameName?.text = game.name
    cell.txtGamePrice?.text = "R\(game.price)"

    return cell

  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Games In Store"
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    switch segue.identifier ?? "" {
    case "showGameDetails":

      guard let gameDetailController = segue.destination as? GameDetailsController else {
        fatalError("Unexpected Destination: \(segue.destination)")
      }

      guard let selectedGameCell = sender as? GameTableViewCell else {
        fatalError("Unextected Sender: \(sender ?? "")")
      }

      guard let indexPath = tableView.indexPath(for: selectedGameCell) else {
        fatalError("Cell is not being displayed")
      }

      let selectedGame = dataViewModel.getGameAt(at: indexPath.row)
      gameDetailController.selectedGame = selectedGame

    default:
      fatalError("Unexpected Segue Identifier")
    }

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
  
  private func stopActivityIndicator() {
    
    DispatchQueue.main.async { [weak self] in
      self?.activityIndicator.stopAnimating()
    }
    
  }
  
  private func reloadTableData() {
    DispatchQueue.main.sync { [weak self] in
      self?.tableView.reloadData()
    }
  }

}

extension GamesViewController: GameDataLoadedType {
  
  func gameDataSuccessfullyLoaded(with data: [Game]) {
    
    tableDataSource = data
    
    stopActivityIndicator()
    reloadTableData()
  
  }
  
}
