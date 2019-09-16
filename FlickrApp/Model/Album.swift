//
//  Album.swift
//  FlickrApp
//
//  Created by Илья on 9/16/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Album{
    let id: String
    let title: String
    let itemsAmount: Int
    let viewsAmount: Int
    let commentsAmount: Int
    let primaryImageId: String
    
    init(data: JSON) {
        self.id = data["id"].stringValue
        self.title = data["title"]["_content"].stringValue
        self.itemsAmount = data["photos"].intValue + data["videos"].intValue
        self.viewsAmount = data["count_views"].intValue
        self.commentsAmount = data["count_comments"].intValue
        self.primaryImageId = data["primary"].stringValue
    }
}
