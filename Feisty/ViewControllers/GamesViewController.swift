//
//  GamesViewController.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/06.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class GamesViewController: UITableViewController {

    private var gameManager: GameManager = GameManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameManager.GameList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath)

        let game: Game = gameManager.GameList[indexPath.row]
        
        cell.textLabel?.text = game.GameName.Text
        cell.detailTextLabel?.text = "R\(game.Price.Amount)"

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Games In Store"
    }
    
}
