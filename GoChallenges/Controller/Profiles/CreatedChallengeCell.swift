//
//  CreatedChallengeCell.swift
//  GoChallenges
//
//  Created by nguyen thy on 8/27/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit

class CreatedChallengeCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var participantLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
