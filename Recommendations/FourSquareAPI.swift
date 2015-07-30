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
    
    func searchVenues (completion: (([Venue]) -> Void)!) {
        println("searchVenues active")
        var urlString = "https://api.foursquare.com/v2/venues/search?ll=40.7,-74&client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&v=20150728"
        let session = NSURLSession.sharedSession()
        let searchURL = NSURL(string: urlString)
        
        var task = session.dataTaskWithURL(searchURL!){
            (data, NSResponse, err: NSError!) -> Void in
            
            if err != nil {
                println(err.localizedDescription)
            } else {
                println("error is nil")
                var err: NSError?
                if let jsonObject: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err){
                    println("jsonObject here")
                    if let dict = jsonObject as? NSDictionary {
                        println("json object is a dictionary")
                        //println(dict)
                        var venues = [Venue]()
                        //println(dict)
                        for (key, value) in dict{
                            let venue = Venue(data: (key as AnyObject, value as AnyObject))
                            // if let venue = (key, value) as? {
                             //   println("venue is a tuple")
                            //}
                            //let venue = Venue(data: (key as! String, value as! String))
                            venues.append(venue)
                            println(venues)
                        
                        }
                        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                        dispatch_async(dispatch_get_global_queue(priority, 0)){
                            dispatch_async(dispatch_get_main_queue()){
                                completion(venues)
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
    
}