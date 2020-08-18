//
//  MyChallengeCell.swift
//  GoChallenges
//
//  Created by nguyen thy on 6/3/20.
//  Copyright © 2020 Han Nguyen. All rights reserved.
//

import UIKit

class MyChallengeCell: UITableViewCell {
    
    @IBOutlet weak var challengeName: UILabel!
    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
