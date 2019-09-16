//
//  DataManager.swift
//  FlickrApp
//
//  Created by Илья on 9/16/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

class DataManager{
    static let instance = DataManager()
    private init(){}
    
    private var albums: [Album] = []
    
    func getAlbums() -> [Album]{
        return albums
    }
    
    func setAlbums(downloadedAlbums: [Album]){
        albums = downloadedAlbums
    }
}
