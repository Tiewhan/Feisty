//
//  FriendsViewController.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/04/03.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController {
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
      return .darkContent
  }
  
  override func viewDidLoad() {
      super.viewDidLoad()

  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 6
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "BasicFriendCell", for: indexPath)

      return cell
  }
    
}
