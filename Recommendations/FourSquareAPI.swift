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
    
    func exploreVenues ((AnyObject) -> Void) {
        var urlString = "https://api.foursquare.com/v2/venues/explore?ll=40.7,-74&client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&v=YYYYMMDD"
        let session = NSURLSession.sharedSession()
        let exploreURL = NSURL(string: urlString)
        
        var task = session.dataTaskWithURL(exploreURL!){
            (NSData, NSResponse, NSError) -> Void in
            
            if NSError != nil {
                println(NSError.localizedDescription)
            } else {
                
            }
        }
        task.resume()
        
    }
    
}