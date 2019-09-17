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
    weak var albumContentDelegate: AlbumContentDelegate?
    
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
    
    func getContent(by id: String){
        let requestString = FlickrConstants.basicRequestUrl+"flickr.photos.getSizes"+FlickrConstants.apiKey+"&photo_id=\(id)"+FlickrConstants.responseFormat+FlickrConstants.noJsonCallback
        Alamofire.request(requestString).responseJSON { (response) in
            guard let value = response.result.value else { return }
            let jsonObject = JSON(value)["sizes"]["size"].arrayValue
            let object = jsonObject[jsonObject.count - 1]
            let type = object["media"].stringValue
            let originalURL = object["source"].stringValue
            var previewURL = ""
            for data in jsonObject{
                if data["label"].stringValue == "Medium"{
                    previewURL = data["source"].stringValue
                }
            }
            let content = Content(type: type, previewURL: previewURL, originalURL: originalURL)
            self.albumCellDelegate?.didFinishDownloadingImageData(content: content)
        }
    }
    
    func getContentList(by id: String){
        var ids: [String] = []
        let requestString = FlickrConstants.basicRequestUrl+"flickr.photosets.getPhotos"+FlickrConstants.apiKey+"&photoset_id=\(id)"+FlickrConstants.responseFormat+FlickrConstants.noJsonCallback
        Alamofire.request(requestString).responseJSON { (response) in
            guard let value = response.result.value else { return }
            let jsonObject = JSON(value)["photoset"]["photo"].arrayValue
            for data in jsonObject{
                let id = data["id"].stringValue
                ids.append(id)
            }
            self.albumContentDelegate?.didFinishDownloadingData(photoIds: ids)
        }
    }
}
