//
//  TableViewCell.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/04/03.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class BasicFriendCell: UITableViewCell {

  @IBOutlet weak var friendAvatar: UIImageView!
  @IBOutlet weak var username: UILabel!
  @IBOutlet weak var status: UILabel!
  
  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

}
