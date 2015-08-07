
//
//  Post.swift
//  Recommendations
//
//  Created by Sarada Symonds on 7/28/15.
//  Copyright (c) 2015 Sarada Symonds. All rights reserved.
//

import UIKit
import RealmSwift

class Post: Object {
    
    dynamic var venue: String = ""
    dynamic var location: String = ""
    dynamic var type: String = ""
    dynamic var price: String = ""
    dynamic var id: String = ""
    //dynamic var id: String = ""
    //dynamic var content: String = ""
    dynamic var imageUrl: String = ""
    dynamic var rating: String = ""
    dynamic var address: String = ""
    
   
}
