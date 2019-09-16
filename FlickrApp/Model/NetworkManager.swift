//
//  NetworkManager.swift
//  FlickrApp
//
//  Created by Илья on 9/16/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager{
    
    weak var launchControllerDelegate: LaunchControllerDelegate?
    weak var albumCellDelegate: AlbumCellDelegate?
    
    func getAlbumsList(){
        let requestString = FlickrConstants.basicRequestUrl+"flickr.photosets.getList"+FlickrConstants.apiKey+"&user_id=\(FlickrConstants.userId)"+FlickrConstants.responseFormat+FlickrConstants.noJsonCallback
        var albums: [Album] = []
        Alamofire.request(requestString).responseJSON { (response) in
            guard let value = response.result.value else { return }
            let jsonObject = JSON(value)["photosets"]
            let jsonArray = jsonObject["photoset"].arrayValue
            for object in jsonArray{
                albums.append(Album(data: object))
            }
            self.launchControllerDelegate?.didFinishDownloadingAlbums(albums: albums)
        }
    }
    
    func getPrimaryImage(primaryImageId: String){
        var content: Content = Content()
        let imageRequestString = FlickrConstants.basicRequestUrl+"flickr.photos.getInfo"+FlickrConstants.apiKey+"&photo_id=\(primaryImageId)"+FlickrConstants.responseFormat+FlickrConstants.noJsonCallback
        Alamofire.request(imageRequestString).responseJSON { (response) in
            guard let imageValue = response.result.value else { return }
            let imageJsonObj = JSON(imageValue)["photo"]
            content = Content(object: imageJsonObj)
            self.albumCellDelegate?.didFinishDownloadingImageData(content: content)
        }
    }
}
