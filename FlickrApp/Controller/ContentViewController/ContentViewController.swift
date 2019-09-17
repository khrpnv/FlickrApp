//
//  ContentViewController.swift
//  FlickrApp
//
//  Created by Илья on 9/17/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit
import SDWebImage

class ContentViewController: UIViewController {

    @IBOutlet private weak var ibImageView: UIImageView!
    @IBOutlet private weak var ibVideoView: UIView!
    
    var content: Content?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContent()
    }
    
    private func getImage(){
        guard let urlStrig = content?.originalURL else { return }
        ibImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        ibImageView.sd_imageIndicator?.startAnimatingIndicator()
        ibImageView.sd_setImage(with: URL(string: urlStrig), completed: nil)
        ibImageView.sd_imageIndicator?.stopAnimatingIndicator()
    }
    
    private func setContent(){
        getImage()
    }
}
