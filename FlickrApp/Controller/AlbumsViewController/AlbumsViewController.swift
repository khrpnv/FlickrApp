//
//  AlbumsViewController.swift
//  FlickrApp
//
//  Created by Илья on 9/16/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var dataSource: [Album] = []{
        didSet{
            tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
        setupDelegates()
        setupTableView()
        setupDataSource()
    }
    
    private func styleUI(){
        self.title = "Albums"
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
    }
    
    private func setupTableView(){
        let cellNib = UINib(nibName: "AlbumTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "AlbumCell")
    }
    
    private func setupDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupDataSource(){
        dataSource = DataManager.instance.getAlbums()
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumTableViewCell else {
            fatalError("Error: no such cell")
        }
        cell.update(album: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumContentViewController = AlbumContentViewController(nibName: "AlbumContentViewController", bundle: nil)
        albumContentViewController.album = dataSource[indexPath.row]
        self.navigationController?.pushViewController(albumContentViewController, animated: true)
    }
    
}
