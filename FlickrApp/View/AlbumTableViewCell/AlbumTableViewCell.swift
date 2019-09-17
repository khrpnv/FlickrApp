//
//  AlbumTableViewCell.swift
//  FlickrApp
//
//  Created by Илья on 9/16/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit
import SDWebImage

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet private weak var ibImageView: UIImageView!
    @IBOutlet private weak var ibTitleLabel: UILabel!
    @IBOutlet private weak var ibInfoLabel: UILabel!
    @IBOutlet private weak var ibArrowContainer: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleUI()
    }
    
    private func styleUI(){
        ibImageView.layer.cornerRadius = ibImageView.frame.height/2
        ibArrowContainer.layer.cornerRadius = ibArrowContainer.frame.height/2
    }
    
    func update(album: Album){
        ibImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        ibImageView.sd_imageIndicator?.startAnimatingIndicator()
        ibTitleLabel.text = album.title
        ibInfoLabel.text = "\(album.itemsAmount) items · \(album.viewsAmount) views · \(album.commentsAmount) comments"
        let networkManager = NetworkManager()
        networkManager.albumCellDelegate = self
        networkManager.getContent(by: album.primaryImageId)
    }
}

//MARK: - AlbumCellDelegate
extension AlbumTableViewCell: AlbumCellDelegate{
    func didFinishDownloadingImageData(content: Content) {
        ibImageView.sd_setImage(with: URL(string: content.originalURL), completed: nil)
        ibImageView.sd_imageIndicator?.stopAnimatingIndicator()
    }
}
