//
//  Content.swift
//  FlickrApp
//
//  Created by Илья on 9/16/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Content{
    let id: String
    let farmId: Int
    let serverId: String
    let secret: String
    let format: String
    
    init(object: JSON) {
        id = object["id"].stringValue
        farmId = object["farm"].intValue
        serverId = object["server"].stringValue
        secret = object["secret"].stringValue
        format = object["originalformat"].stringValue
    }
    
    init(){
        id = "0"
        farmId = 0
        serverId = "0"
        secret = "0"
        format = "0"
    }
    
    var contentUrl: URL {
        return URL(string: "https://farm\(farmId).staticflickr.com/\(serverId)/\(id)_\(secret)_m.\(format)")!
    }
}
