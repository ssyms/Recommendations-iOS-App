//
//  VenueViewController.swift
//  Recommendations
//
//  Created by Sarada Symonds on 8/6/15.
//  Copyright (c) 2015 Sarada Symonds. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation

class VenueViewController: UIViewController {
    
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceTierLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        displayPost(post)
    }
    
    
    var post: Post? {
        didSet {
            displayPost(post)
        }
    }
    
    
    func displayPost(post: Post?) {
        if let post = post, venueLabel = venueLabel, typeLabel = typeLabel, addressLabel = addressLabel, countryLabel = countryLabel, ratingLabel = ratingLabel, priceTierLabel = priceTierLabel, descriptionLabel = descriptionLabel, venueImage = venueImage {
            self.venueLabel.text = post.venue
            self.countryLabel.text = post.location
            self.priceTierLabel.text = post.price
            self.typeLabel.text = post.type
            let urlString = post.imageUrl
            if let url = NSURL(string: urlString) {
                self.venueImage.sd_setImageWithURL(url, placeholderImage: nil)
            }

            //self.addressLabel.text = post.address
            //self.ratingLabel.text = post.rating
            //self.descriptionLabel.text = post.description
        }
    }
    
    
}
