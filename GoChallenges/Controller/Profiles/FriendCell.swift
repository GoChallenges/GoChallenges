//
//  FriendCell.swift
//  GoChallenges
//
//  Created by nguyen thy on 8/5/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}