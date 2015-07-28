//
//  PostTableViewCell.swift
//  Recommendations
//
//  Created by Sarada Symonds on 7/28/15.
//  Copyright (c) 2015 Sarada Symonds. All rights reserved.
//

import UIKit
class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var venueImage: UIImageView!
    
    var post: Post? {
        didSet {
            if let post = post, venueLabel = venueLabel, locationLabel = locationLabel, typeLabel = typeLabel, priceLabel = priceLabel {
                self.venueLabel.text = post.venue
                self.locationLabel.text = post.location
                self.priceLabel.text = post.price
                self.typeLabel.text = post.type
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
