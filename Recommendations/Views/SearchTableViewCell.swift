//
//  SearchTableViewCell.swift
//  Recommendations
//
//  Created by Sarada Symonds on 7/28/15.
//  Copyright (c) 2015 Sarada Symonds. All rights reserved.
//

import UIKit

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
        }
    }
    
    var canAdd: Bool? = true {
        didSet {
            /*
            Change the state of the follow button based on whether or not
            it is possible to follow a user.
            */
            if let canAdd = canAdd {
                addButton.selected = !canAdd
            }
        }
    }
    
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        if let canAdd = canAdd where canAdd == true {
            delegate?.cell(self, didSelectAddVenue: venue!)
            self.canAdd = false
            /*let source = segue.sourceViewController as! SearchTableViewController //1
            
            realm.write() {
                realm.add(source.currentNote!)
            } */
        } else {
            delegate?.cell(self, didSelectUnAddVenue: venue!)
            self.canAdd = true
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