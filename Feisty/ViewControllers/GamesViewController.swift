//
//  GamesViewController.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/06.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class GamesViewController: UITableViewController {

    var observerID: String = "GameListSubscriber"

    private var gameManager: GameManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        gameManager = GameManager()
        gameManager?.subscribeToGameManager(subscriber: self, subscriberID: observerID)

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

        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath)

        if let gameManager = gameManager {

            let game: Game = gameManager.gameList[indexPath.row]
            cell.textLabel?.text = game.name
            cell.detailTextLabel?.text = "R\(game.price)"

        }

        return cell

    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Games In Store"
    }

}

extension GamesViewController: GameManagerObserver {

  func gamesFinishedLoading() {
      DispatchQueue.main.sync { self.tableView.reloadData() }
  }

}
