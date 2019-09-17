//
//  AlbumContentDelegate.swift
//  FlickrApp
//
//  Created by Илья on 9/17/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

protocol AlbumContentDelegate: class {
    func didFinishDownloadingData(photoIds: [String])
}
