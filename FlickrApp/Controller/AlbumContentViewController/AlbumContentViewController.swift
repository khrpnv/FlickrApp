//
//  AlbumContentViewController.swift
//  FlickrApp
//
//  Created by Илья on 9/16/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class AlbumContentViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var ibActivityIndicator: UIActivityIndicatorView!
    
    var album: Album?
    private var dataSource: [String] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
        downloadData()
        setupDelegates()
        setupCollectionView()
    }
    
    private func styleUI(){
        self.title = album?.title
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        collectionView.isHidden = true
    }
    
    private func setupDelegates(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupCollectionView(){
        let cellNib = UINib(nibName: "ContentCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "ContentCell")
    }
    
    private func downloadData(){
        let networkManager = NetworkManager()
        networkManager.albumContentDelegate = self
        networkManager.getContentList(by: album?.id ?? "")
    }
    
    private func getVideo(content: Content?){
        guard let originalURL = content?.originalURL else { return }
        guard let url = URL(string: originalURL) else { return }
        let player = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.player = player
        controller.view.frame = self.view.frame
        self.present(controller, animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDelegate
extension AlbumContentViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ContentCollectionViewCell else { return }
        if cell.content?.type == "video"{
            getVideo(content: cell.content)
        } else {
            let contentViewController = ContentViewController(nibName: "ContentViewController", bundle: nil)
            contentViewController.content = cell.content
            self.navigationController?.pushViewController(contentViewController, animated: true)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension AlbumContentViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath) as? ContentCollectionViewCell else {
            fatalError("Error: No such cell")
        }
        cell.update(imageId: dataSource[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension AlbumContentViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 15, height: view.frame.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

//MARK: - AlbumContentDelegate
extension AlbumContentViewController: AlbumContentDelegate{
    func didFinishDownloadingData(photoIds: [String]) {
        ibActivityIndicator.isHidden = true
        dataSource = photoIds
        collectionView.isHidden = false
    }
}
