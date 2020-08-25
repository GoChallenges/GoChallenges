//
//  ProfileChallengeCell.swift
//  GoChallenges
//
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit
import CircleProgressView

class ProfileChallengeCell: UITableViewCell {
    @IBOutlet weak var circleProgressView: CircleProgressView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var challengeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
