//
//  Venue.swift
//  Recommendations
//
//  Created by Sarada Symonds on 7/29/15.
//  Copyright (c) 2015 Sarada Symonds. All rights reserved.
//

import Foundation

class Venue{
    
    var id: String!
    var name: String!
    //var contacts: NSObject!
    //var location: String!
    //var categories: String!
    /*
    var verified: String!
    var stats: String!
    var url: String!
    var hours: String!
    var price: String!
    var rating: String!
    var description: String!
    var photos: NSObject!
    

    */
    
    
    init(data: [String: AnyObject]){
        self.id = data["id"] as? String
        self.name = data["name"] as? String
    }
    
    func getStringFromJSON(data: NSDictionary, key: String) -> String{
        if let info = data[key] as? String {
            return info
        }
        return ""
    }
}