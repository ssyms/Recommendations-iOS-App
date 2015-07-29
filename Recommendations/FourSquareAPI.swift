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
    
    func searchVenues (completion: ((AnyObject) -> Void)!) {
        var urlString = "https://api.foursquare.com/v2/venues/explore?ll=40.7,-74&client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&v=YYYYMMDD"
        let session = NSURLSession.sharedSession()
        let searchURL = NSURL(string: urlString)
        
        var task = session.dataTaskWithURL(searchURL!){
            (NSData, NSResponse, err: NSError!) -> Void in
            
            if err != nil {
                println(err.localizedDescription)
            } else {
                var err: NSError?
                var venuesData = NSJSONSerialization.JSONObjectWithData(NSData, options: nil, error: &err) as! NSArray
                var venues = [Venue]()
                for venue in venuesData{
                    let venue = Venue(data: venue as! NSDictionary)
                    venues.append(venue)
                }
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)){
                    dispatch_async(dispatch_get_main_queue()){
                        completion(venues)
                    }
                }
            }
        }
        task.resume()
        
    }
    
}