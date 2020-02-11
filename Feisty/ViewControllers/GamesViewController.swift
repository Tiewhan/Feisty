//
//  GamesViewController.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/06.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class GamesViewController: UITableViewController, GameManagerObserver {
    
    var observerID: String = "GameListSubscriber"
    
    private var gameManager: GameManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        gameManager = GameManager()
        gameManager?.subscribeToGameManagerObserver(subscriber: self, subscriberID: observerID)
        
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
    
    func gamesFinishedLoading() {
        DispatchQueue.main.sync { self.tableView.reloadData() }
    }
    
}
