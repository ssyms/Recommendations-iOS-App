//
//  SearchTableViewController.swift
//  Recommendations
//
//  Created by Sarada Symonds on 7/28/15.
//  Copyright (c) 2015 Sarada Symonds. All rights reserved.
//

//
//  SearchTableViewController.swift
//  Recommendations
//
//  Created by Sarada Symonds on 7/28/15.
//  Copyright (c) 2015 Sarada Symonds. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift
import CoreLocation

class SearchTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var locManager : CLLocationManager!
    var currentLL: String!
    var venues: [Venue]!
    
    var AddedVenues: [Venue]? {
        didSet {
            /**
            the list of following users may be fetched after the tableView has displayed
            cells. In this case, we reload the data to reflect "following" status
            */
            tableView.reloadData()
        }
    }
    
    
    enum State {
        case DefaultMode
        case SearchMode
    }
    
    
    // whenever the state changes, perform one of the two queries and update the list
    var state: State = .DefaultMode {
        didSet {
            switch (state) {
            case .DefaultMode:
                loadInitialData()
                
            case .SearchMode:
                loadInitialData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "logo2.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        loadInitialData()
        
        //var currentLocation = CLLocation!
        
        /*if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse){
        
        currentLocation = locManager.location
        
        }*/
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadInitialData() {
        venues = [Venue]()
        locManager = CLLocationManager()
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        if self.venues.isEmpty {
            if let currentLocation : CLLocation = manager.location {
                
                let latitude = "\(currentLocation.coordinate.latitude)"
                let longitude = "\(currentLocation.coordinate.longitude)"
                self.currentLL = latitude + "," + longitude
                let api = FourSquareAPI()
                api.searchVenues(didSearchVenues, ll: self.currentLL)
            } else {
                println("nil loc")
            }
        }
    }
    
    
    func didSearchVenues(venues: [Venue]){
        self.venues = venues
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! SearchTableViewCell //1
        
        let venue = venues[indexPath.row]
        cell.venueLabel!.text = venue.name
        if venue.city.isEmpty == false && venue.state.isEmpty == false {
            cell.locationLabel!.text = venue.city + ", " + venue.state
        } else if venue.country.isEmpty == false &&  venue.city.isEmpty == false {
            cell.locationLabel!.text = venue.city + ", " + venue.country
        } else if venue.country.isEmpty == false &&  venue.state.isEmpty == false {
            cell.locationLabel!.text = venue.state + ", " + venue.country
        } else {
            cell.locationLabel!.text = venue.country
        }
        cell.typeLabel!.text = venue.category
        if venue.priceTier == "" {
            cell.priceLabel!.text = ""
        } else {
            cell.priceLabel!.text = "•  " + venue.priceTier
        }
        
        let realm = Realm()
        var posts = realm.objects(Post).filter("id = '\(venue.id!)'")
         cell.canAdd = true
        if posts.count > 0 {
            for object in posts{
                if venue.id == object.id {
                    cell.canAdd = false
                }
            }
        }
        //cell.idLabel!.text = venue.id
        cell.venue = venue
        cell.delegate = self
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
        
    }
    
}

extension SearchTableViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        state = .SearchMode
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        state = .DefaultMode
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
                let api = FourSquareAPI()
                if searchBar.text.isEmpty == false {
                    api.searchVenuesWithQuery(didSearchVenues, query: searchText, ll: self.currentLL)
                } else {
                    loadInitialData()
                }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
}

extension SearchTableViewController: SearchTableViewCellDelegate {
    
    func cell(cell: SearchTableViewCell, didSelectAddVenue: Venue) {
        
    }
    
    func cell(cell: SearchTableViewCell, didSelectUnAddVenue: Venue) {
        
    }
    
}

/*extension SearchTableViewController: UITableViewDataSource {

override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
let cell = searchTableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! SearchTableViewCell //1

let row = indexPath.row
cell.venueLabel.text = "Fake Venue"
cell.locationLabel.text = "SF"
cell.priceLabel.text = "$$$"
cell.typeLabel.text = "Desert"

return cell
}

override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return 5

}


}*/

/*override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
// #warning Incomplete method implementation.
// Return the number of rows in the section.
return 0
}*/

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

