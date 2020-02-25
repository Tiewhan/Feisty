//
//  GamesViewController.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/06.
//  Copyright © 2020 DVT. All rights reserved.
//
import UIKit

/// Represents an individual cell for the Game Table View
class GameTableViewCell: UITableViewCell {

  @IBOutlet weak var detailsStackView: UIStackView!
  @IBOutlet weak var txtViewGameName: UITextView!
  @IBOutlet weak var txtGamePrice: UILabel!

  private lazy var backGroundView: UIView = {
    let view = UIView()
    view.backgroundColor = .darkGray
    return view
  }()

  /**
   Pings the given view as a background to the given stackview
   
   - parameter view: The view that will be the background
   - parameter stackView: The stack that needs to have the background added to
   */
  private func pinBackGround(_ view: UIView, to stackView: UIStackView) {
    view.translatesAutoresizingMaskIntoConstraints = false
    stackView.insertSubview(view, at: 0)
    view.layer.cornerRadius = 10.0
    view.pin(to: stackView)
  }

  ///The cell equivalent of viewDidLoad
  override func layoutSubviews() {
    super.layoutSubviews()
    pinBackGround(backGroundView, to: detailsStackView)

  }

}

public extension UIView {

  /**
   All constraints of the given view are set equal to the corresponding anchors of this view
   */
  func pin(to view: UIView) {

    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: view.leadingAnchor),
      trailingAnchor.constraint(equalTo: view.trailingAnchor),
      topAnchor.constraint(equalTo: view.topAnchor),
      bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

  }

}

// MARK: Controllers
class GamesViewController: UITableViewController {

  // MARK: Properties and Outlets
  var observerID: String = "GameListSubscriber"
  private var gameManager: GameManager?
  @IBOutlet var mainView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  override func viewDidLoad() {
    super.viewDidLoad()

    gameManager = GameManager()
    gameManager?.subscribeToGameManager(subscriber: self, subscriberID: observerID)

    setUpActivityInidcator()

  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let gameManager = gameManager {
      return gameManager.gameList.count
    }

    return 0
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
      as? GameTableViewCell else {
      return UITableViewCell()
    }

    if let gameManager = gameManager {

      let game: Game = gameManager.gameList[indexPath.row]
      cell.txtViewGameName?.text = game.name
      cell.txtGamePrice?.text = "R\(game.price)"

    }

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

      let selectedGame = gameManager?.gameList[indexPath.row]
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

}

// MARK: Game Observer Etensions
extension GamesViewController: GameManagerObserver {

  ///Called when the game manager has finished loading all of the data needed
  func gamesFinishedLoading() {

    DispatchQueue.main.async {

      [weak self] in
      self?.activityIndicator.stopAnimating()

    }
    DispatchQueue.main.sync { self.tableView.reloadData() }
  }

}
