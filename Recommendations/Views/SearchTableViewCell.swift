//
//  SearchTableViewCell.swift
//  Recommendations
//
//  Created by Sarada Symonds on 7/28/15.
//  Copyright (c) 2015 Sarada Symonds. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

protocol SearchTableViewCellDelegate: class {
    func cell(cell: SearchTableViewCell, didSelectAddVenue venue: Venue)
    func cell(cell: SearchTableViewCell, didSelectUnAddVenue venue: Venue)
}

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    weak var delegate: SearchTableViewCellDelegate?
    
    var venue: Venue? {
        didSet {
            venueLabel.text = venue?.name
            
            venueImage.image = nil
            if let urlString = venue!.imageUrl {
                if let url = NSURL(string: urlString) {
                        venueImage.sd_setImageWithURL(url, placeholderImage: nil)
                }
            }
            if venueImage.image == nil {
                venueImage.image = UIImage(named: "fillerImage.png")
            }
        }
    }
    
    var currentCell: Post? {
        didSet {
            if let currentCell = currentCell, venueLabel = venueLabel, locationLabel = locationLabel, typeLabel = typeLabel, priceLabel = priceLabel, venueImage = venueImage {
                self.venueLabel.text = currentCell.venue
                self.locationLabel.text = currentCell.location
                self.priceLabel.text = currentCell.price
                self.typeLabel.text = currentCell.type
            }
        }
    }
    

    var canAdd: Bool? = true {
        didSet {
            if let canAdd = canAdd {
                addButton.selected = !canAdd
            }
            
        }
    }
    


    
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        if let canAdd = canAdd where canAdd == true {
            delegate?.cell(self, didSelectAddVenue: venue!)
            self.canAdd = false
            let addedPost = Post()
            addedPost.venue   = venueLabel.text!
            addedPost.location = locationLabel.text!
            addedPost.type = priceLabel.text!
            addedPost.price = typeLabel.text!
            addedPost.id = venue!.id!
            if venue!.imageUrl == nil {
                addedPost.imageUrl = ""
            } else {
                addedPost.imageUrl = venue!.imageUrl!
            }
            addedPost.address = venue!.address!
            //addedPost.rating = venue!.rating!
            
            let realm = Realm()
            realm.write( ) { // 2
                realm.add(addedPost) // 3
            }
        } else {
            delegate?.cell(self, didSelectUnAddVenue: venue!)
            let realm = Realm()
            var posts = realm.objects(Post).filter("id = '\(venue!.id!)'")
            
            if posts.count > 0 {
                realm.write() {
                    realm.delete(posts[0])
                }
            }
            
            /*realm.write() {
            realm.delete(self.currentCell!)
            }*/
            self.canAdd = true
        }
    }
    
    
    /*static func getAddedVenues() {
    let query = PFQuery(className: ParseFollowClass)
    
    query.whereKey(ParseFollowFromUser, equalTo:user)
    query.findObjectsInBackgroundWithBlock(completionBlock)
    }*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}