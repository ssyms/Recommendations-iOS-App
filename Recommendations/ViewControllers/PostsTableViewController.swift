//
//  PostsTableViewController.swift
//  Recommendations
//
//  Created by Sarada Symonds on 7/28/15.
//  Copyright (c) 2015 Sarada Symonds. All rights reserved.
//

import UIKit
import RealmSwift
import MessageUI

class PostsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var myTableView: UITableView!
    
    var selectedPost: Post?
    var emailList = [Post]()
    var posts: Results<Post>! {
        didSet {
            // Whenever posts update, update the table view
            myTableView?.reloadData()
        }
    }
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var share2Button: UIBarButtonItem!
    
    @IBAction func shareButtonTapped(sender: AnyObject) {
        shareButton.enabled = false
        shareButton.title = nil
        share2Button.enabled = true
        share2Button.title = "Email List"
        
        tableView.editing = !tableView.editing
    }
    @IBAction func share2ButtonTapped(sender: AnyObject) {
        shareButton.enabled = true
        shareButton.title = "Share Your Favorites Bites!"
        share2Button.enabled = false
        share2Button.title = nil
        tableView.editing = false
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
        mailComposerVC.setSubject("Try some bites!")
        var emailString = "<h4><font face='tahoma'>Check out these awesome places!</font></h4>"
        for item in emailList {
            var venueString = item.venue
            println(item.venue)
            item.venue = ""
            var addressString = item.address
            var locationString = item.location
            var formatLoc = addressString + ", " + locationString
            var typeString = item.price
            var completeVenue = "<h2>" + venueString + "</h2> " + typeString + " • " + formatLoc
            venueString = ""
            addressString = ""
            locationString = ""
            emailString = emailString + completeVenue
        }
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
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        
        if let identifier = segue.identifier {
            let realm = Realm()
            switch identifier {
            case "Done":
                posts = realm.objects(Post).sorted("venue", ascending: true)
                
            default:
                posts = realm.objects(Post).sorted("venue", ascending: true)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "logo2.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        shareButton.title = "Share Your Favorites Bites!"
        share2Button.enabled = false
        share2Button.title = nil
        tableView.dataSource = self
        tableView.delegate = self
        let realm = Realm()
        posts = realm.objects(Post).sorted("venue", ascending: true)
        
        tableView.allowsSelectionDuringEditing = true
        tableView.allowsMultipleSelection = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowVenueDetails") {
            if let cell = sender as? PostTableViewCell {
                let venueViewController = segue.destinationViewController as! VenueViewController
                venueViewController.post = cell.post
            }
        }
    }
    
    // MARK: - Table view data source
    
    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0
    }*/
    
    /*override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0
    } */
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
    
    // Configure the cell...
    
    return cell
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}



extension PostsTableViewController: UITableViewDataSource {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostTableViewCell //1
        
        let row = indexPath.row
        let post = posts[row] as Post
        cell.post = post
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(posts?.count ?? 0)
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedPost = posts[indexPath.row]
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if tableView.editing == false {
            self.performSegueWithIdentifier("ShowVenueDetails", sender: cell)
        }
        
        if let indexPaths = tableView.indexPathsForSelectedRows() as? [NSIndexPath] {
            for item in indexPaths {
                let row = item.row
                var post = posts[row] as Post
                var emailPost = Post()
                emailPost.venue = post.venue
                emailPost.location = post.location
                emailPost.address = post.address
                emailPost.type = post.type
                emailList.append(emailPost)
                
            }
        }
    }
    
    // 3
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // 4
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let post = posts[indexPath.row] as Object
            
            let realm = Realm()
            
            realm.write() {
                realm.delete(post)
            }
            
            posts = realm.objects(Post).sorted("venue", ascending: true)
        }
    }
    
    
}
