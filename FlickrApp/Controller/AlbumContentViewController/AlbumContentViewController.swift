//
//  AlbumContentViewController.swift
//  FlickrApp
//
//  Created by Илья on 9/16/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit

class AlbumContentViewController: UIViewController {

    var album: Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
    }
    
    private func styleUI(){
        self.title = album?.title
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
    }

}
