//
//  LaunchViewController.swift
//  FlickrApp
//
//  Created by Илья on 9/16/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let networkManager = NetworkManager()
        networkManager.launchControllerDelegate = self
        FlickrConstants.userId = "184398811@N02"
        networkManager.getAlbumsList()
    }

}

//MARK: - LaunchControllerDelegate
extension LaunchViewController: LaunchControllerDelegate{
    func didFinishDownloadingAlbums(albums: [Album]) {
        DataManager.instance.setAlbums(downloadedAlbums: albums)
        let albumsViewController = AlbumsViewController(nibName: "AlbumsViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: albumsViewController)
        self.dismiss(animated: true, completion: nil)
        self.present(navigationController, animated: true, completion: nil)
    }
}
