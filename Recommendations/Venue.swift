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
    var address: String!
    var cc: String!
    var country: String!
    var city: String!
    var state: String!
    var category: String!
    var priceTier: String!
    var imageUrl: String!
    
    /*
    var hours: String!
    var price: String!
    var rating: String!
    var description: String!

    */
    
    
    init(data: [String: AnyObject]){
        self.id = data["id"] as? String
        self.name = data["name"] as? String
        self.address = getStringFromDict(data, key: "location", key2: "address")
        self.cc = getStringFromDict(data, key: "location", key2: "cc")
        self.country = getStringFromDict(data, key: "location", key2: "country")
        self.city = getStringFromDict(data, key: "location", key2: "city")
        self.state = getStringFromDict(data, key: "location", key2: "state")
        self.priceTier = getStringFromDict(data, key: "price", key2: "currency")
        self.category = accessCat(data, key: "categories", key2: "name")
        self.imageUrl = getPicUrl(data, key: "prefix") + "500x500" + getPicUrl(data, key: "suffix")
    }
    
    func accessCat(data: NSDictionary, key: String, key2: String) -> String{
        if let newData: AnyObject = data[key]{
            if let response = newData[0] as? [String: AnyObject] {
                return (response[key2] as? String)!
            }
            else{
                return ""
            }
        }else {
            return ""
        }
    }

    func getStringFromDict(data: NSDictionary, key: String, key2: String) -> String{
        if let newData: AnyObject = data[key]{
            if let info = newData[key2] as? String {
                return info
            } else {
                return ""
            }
            }else{
            return ""
        }
    }
    
    func getPicUrl(data: NSDictionary, key: String) -> String{
        if let newData: AnyObject = data["featuredPhotos"]{
            return accessCat(newData as! NSDictionary, key: "items", key2: key)
        } else {
            
        }
        return ""
    }

}

