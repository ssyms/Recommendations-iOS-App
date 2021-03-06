//
//  FourSquareAPI.swift
//  Recommendations
//
//  Created by Sarada Symonds on 7/29/15.
//  Copyright (c) 2015 Sarada Symonds. All rights reserved.
//

import Foundation

class FourSquareAPI {
    let CLIENT_ID = "W2QID5ADBMRLJ5YORFJ1JVMXJW3XCLOWBPZZG0WUK0OBUWOL"
    let CLIENT_SECRET = "YAYW3VGX04GSK0Z0B5WSYWOFIR21WBBOJ2TIUI1COQUO4UM5"
    
    func searchVenues (completion: (([Venue]) -> Void)!, ll: String) {
        var urlString = "https://api.foursquare.com/v2/venues/search?ll=" + ll + "&categoryId=4d4b7105d754a06374d81259,4d4b7105d754a06376d81259&client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&v=20150728"
        
        
        let session = NSURLSession.sharedSession()
        let searchURL = NSURL(string: urlString)
        
        var task = session.dataTaskWithURL(searchURL!){
            (data, NSResponse, err: NSError!) -> Void in
            
            if err != nil {
                println(err.localizedDescription)
            } else {
                var err: NSError?
                if let jsonObject: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err){
                    var venues = [Venue]()
                    if let dict = jsonObject as? [String: AnyObject] {
                        if let response = dict["response"] as? [String: AnyObject] {
                            if let venuesData = response["venues"] as? [[String: AnyObject]] {
                                for item in venuesData {
                                    let venue = Venue(data: item)
                                    venues.append(venue)
                                    self.getVenuePhotos(venue.id, venue: venue)

                                }
                                
                        
                                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                                dispatch_async(dispatch_get_global_queue(priority, 0)){
                                    dispatch_async(dispatch_get_main_queue()){
                                        completion(venues)
                                    }
                                }
                            }
                        }
                        
                        
                    } else {
                        
                    }
                } else {
                    println("Could not parse JSON: \(err!)")
                }
                
            }
        }
        task.resume()
        
    }
    
    
    func searchVenuesWithQuery (completion: (([Venue]) -> Void)!, query: String, ll: String) {
        let urlQuery = query.stringByReplacingOccurrencesOfString(" ", withString: "_")
        var urlString = "https://api.foursquare.com/v2/venues/search?ll=" + ll + "&categoryId=4d4b7105d754a06374d81259,4d4b7105d754a06376d81259&client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&v=20150728&query=" + urlQuery
        
        let session = NSURLSession.sharedSession()
        let searchURL = NSURL(string: urlString)
        
        var task = session.dataTaskWithURL(searchURL!){
            (data, NSResponse, err: NSError!) -> Void in
            
            if err != nil {
                println(err.localizedDescription)
            } else {
                var err: NSError?
                if let jsonObject: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err){
                    var venues = [Venue]()
                    if let dict = jsonObject as? [String: AnyObject] {
                        if let response = dict["response"] as? [String: AnyObject] {
                            if let venuesData = response["venues"] as? [[String: AnyObject]] {
                                for item in venuesData {
                                    let venue = Venue(data: item)
                                    venues.append(venue)
                                    self.getVenuePhotos(venue.id, venue: venue)
                                    
                                }
                                
                                dispatch_async(dispatch_get_main_queue()){
                                        completion(venues)
                                    }
                                
                            }
                        }
                        
                        
                    } else {
                        
                    }
                } else {
                    println("Could not parse JSON: \(err!)")
                }
                
            }
        }
        task.resume()
        
    }
    
    func getVenuePhotos(venueID: String!, venue: Venue) -> Void {
        var urlStringA = "https://api.foursquare.com/v2/venues/" + venue.id + "/photos?&client_id="
        var urlStringB = CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&v=20150728"
        var urlString = urlStringA + urlStringB
        let session = NSURLSession.sharedSession()
        let searchURL = NSURL(string: urlString)
        
        var task = session.dataTaskWithURL(searchURL!){
            (data, NSResponse, err: NSError!) -> Void in
            
            if err != nil {
                println(err.localizedDescription)
            } else {
                var err: NSError?
                if let jsonObject: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err){
                    var venues = [Venue]()
                    if let dict = jsonObject as? [String: AnyObject] {
                        if let response = dict["response"] as? [String: AnyObject]{
                            if let photos = response["photos"] as? [String: AnyObject]{
                                if let items = photos["items"] as? [[String: AnyObject]] {
                                    for item in items {
                                        while venue.imageUrl == nil {
                                            let pre = item["prefix"] as! String
                                            let suf = item["suffix"] as! String
                                            let newUrl = pre + "500x500" + suf
                                            venue.imageUrl = newUrl
                                        }
                                    }
                                    if venue.imageUrl == nil {
                                        venue.imageUrl = venue.catUrl
                                    }
                                }

                                
                            }

                            
                        }
                       let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                                dispatch_async(dispatch_get_global_queue(priority, 0)){
                                    dispatch_async(dispatch_get_main_queue()){
                                    }
                                }
                            
                        }
                        
                        
                     else {
                        
                    }
                } else {
                    println("Could not parse JSON: \(err!)")
                }
                
            }
        }
        task.resume()
        
    }

    
}