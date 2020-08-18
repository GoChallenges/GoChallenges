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
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var progressIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addProgressIcon(number: 7)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func addProgressIcon(number: Int) {
        let image = #imageLiteral(resourceName: "Progress Icon")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
//
//        var imageArray = [UIImageView]()
//        for _ in 1...number {
//            imageArray.append(imageView)
//        }
//
//        for image in imageArray {
//            stackView.addSubview(image)
//            print("Yes")
//        }
        let image1 = #imageLiteral(resourceName: "Progress Icon")
        let imageView1 = UIImageView(image: image1)
        imageView1.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        stackView.addSubview(imageView1)
        stackView.addSubview(progressIcon)
    }
}
