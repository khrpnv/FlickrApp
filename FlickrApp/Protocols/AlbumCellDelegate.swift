//
//  AlbumCellDelegate.swift
//  FlickrApp
//
//  Created by Илья on 9/16/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

protocol AlbumCellDelegate: class {
    func didFinishDownloadingImageData(content: Content)
}
