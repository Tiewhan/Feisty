//
//  FriendsViewController.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/04/03.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit
import CommonFiles

class FriendsViewController: UITableViewController {
  
  @IBOutlet var table: UITableView!
  
  private lazy var viewModel: FriendListViewModelType = {
    return FriendListViewModel(withView: self,
                               andModel: FriendListModel(withRepo: FriendListAPIRepo(),
                                                         andImageRepo: FriendImageAPIRepo()))
  }()
  
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
    return viewModel.getAmountOfFriends()
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasicFriendCell", for: indexPath)
      as? BasicFriendCell else {
      return UITableViewCell()
    }
    
    let user: UserDataTransferObject = viewModel.getFriend(at: indexPath.row)
    
    cell.status.text = user.status
    cell.username.text = user.username

    return cell
    
  }
  
  private func reloadTableData() {
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }
  }
  
  func createAndShowAlert(message: String, handler: @escaping((UIAlertAction) -> Void)) {
    
    let alertController = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
    alertController.message = message
    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: handler))
    self.present(alertController, animated: true, completion: nil)
    
  }
    
}

extension FriendsViewController: FriendListViewType {
  
  func foundImageOfCell(at index: Int, image: UIImage?) {
    
    DispatchQueue.main.async {
      
      let indexPath = IndexPath(row: index, section: 0)
      let cell = self.table.cellForRow(at: indexPath) as? BasicFriendCell
      
      cell?.friendAvatar.image = image
      
    }
    
  }
  
  func errorLoadingData() {
    createAndShowAlert(message: "Could Not Load Friends") { _ in }
  }
  
  func dataLoaded() {
    reloadTableData()
  }
  
}
