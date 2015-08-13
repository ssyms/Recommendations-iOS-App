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
import MessageUI

class VenueViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceTierLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "logo2.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        displayPost(post)
    }
    
    
    var post: Post? {
        didSet {
            displayPost(post)
        }
    }
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    
    @IBAction func shareButtonTapped(sender: AnyObject) {
        println("share button tapped")
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([""])
        let venueString = post?.venue
        let addressString = post?.address
        let locationString = post?.location
        let formatLoc = addressString! + ", " + locationString!
        let typeString = post?.price
        let emailString = "<h4><font face='tahoma'>Check out this awesome place!</font></h4><h2>" + venueString! + "</h2> " + typeString! + " • " + formatLoc
        mailComposerVC.setSubject("Try a Bite!")
        mailComposerVC.setMessageBody(emailString, isHTML: true)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func displayPost(post: Post?) {
        if let post = post, venueLabel = venueLabel, typeLabel = typeLabel, addressLabel = addressLabel, countryLabel = countryLabel, ratingLabel = ratingLabel, priceTierLabel = priceTierLabel, venueImage = venueImage {
            self.venueLabel.text = post.venue
            self.countryLabel.text = post.location
            self.priceTierLabel.text = post.price
            self.typeLabel.text = post.type
            self.ratingLabel.text = post.rating
            self.addressLabel.text = post.address
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
