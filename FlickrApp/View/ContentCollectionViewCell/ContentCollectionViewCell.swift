//
//  ContentCollectionViewCell.swift
//  FlickrApp
//
//  Created by Илья on 9/17/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit
import SDWebImage

class ContentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var ibImageView: UIImageView!
    @IBOutlet private weak var ibPlayVideoIcon: UIView!
    
    var content: Content?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleUI()
    }
    
    private func styleUI(){
        ibImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        ibImageView.sd_imageIndicator?.startAnimatingIndicator()
        ibImageView.layer.cornerRadius = 10
        ibPlayVideoIcon.layer.cornerRadius = ibPlayVideoIcon.frame.height/2
        ibPlayVideoIcon.isHidden = true
    }

    func update(imageId: String){
        let networkManager = NetworkManager()
        networkManager.albumCellDelegate = self
        networkManager.getContent(by: imageId)
    }
}

//MARK: - AlbumCellDelegate
extension ContentCollectionViewCell: AlbumCellDelegate{
    func didFinishDownloadingImageData(content: Content) {
        ibImageView.sd_setImage(with: URL(string: content.previewURL), completed: nil)
        ibImageView.sd_imageIndicator?.stopAnimatingIndicator()
        if content.type == "video"{
            ibPlayVideoIcon.isHidden = false
        } else {
            ibPlayVideoIcon.isHidden = true
        }
        self.content = content
    }
}
