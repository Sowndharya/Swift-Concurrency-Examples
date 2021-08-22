//
//  ViewController.swift
//  Swift Concurrency Examples
//
//  Created by Sowndharya Maheswaran on 22/08/21.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet weak var tableViewPhotos: UITableView!
    var refreshControl = UIRefreshControl()
        
    var photosModel = PhotosModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPhotos.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc func refresh() {
        tableViewPhotos.reloadData()
        refreshControl.endRefreshing()
    }
}

extension PhotosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosModel.photoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        let photoItem = photosModel.photoItems[indexPath.row]
        cell?.textLabel?.text = photoItem.name
        cell?.imageView?.image = UIImage(named: "Placeholder")
        return cell ?? UITableViewCell()
    }
}

extension PhotosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        Task {
            let image = await photosModel.fetchImage(at: indexPath.row)
            display(image: image, in: cell)
        }
    }
    
    func display(image: UIImage!, in cell: UITableViewCell) {
        guard let image = image else {
            cell.imageView?.image = UIImage(named: "Placeholder")
            return
        }
        cell.imageView?.image = image
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kThumbnailHeight
    }
}
