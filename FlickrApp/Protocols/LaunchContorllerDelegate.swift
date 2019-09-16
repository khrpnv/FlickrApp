//
//  LaunchContorllerDelegate.swift
//  FlickrApp
//
//  Created by Илья on 9/16/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

protocol LaunchControllerDelegate: class {
    func didFinishDownloadingAlbums(albums: [Album])
}
