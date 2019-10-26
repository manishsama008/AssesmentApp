//
//  InstagramViewController.swift
//  AssesmentApp
//
//  Created by Manish Sama on 10/24/19.
//  Copyright © 2019 Manish Sama. All rights reserved.
//

import UIKit

class InstagramViewController: UIViewController {
    
    var images = [SelfieImageObject]()
    let cellHeight: CGFloat = 200.0
    var page: Int = 1
    var totalImages: Int?
    let imageCache = NSCache<NSString, UIImage>()
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesCollectionView.registerCell(a: ImageCollectionViewCell())
        loadData(page: 1)
    }
    
    func loadData(page: Int) {
        let urlString = AppConstants.PHOTOS_URL + "&page=\(page)"
        NetworkManager.shared.makeANetworkCallFor(urlString: urlString) { [weak self] (success, json) in
            if success {
                DispatchQueue.main.async {
                    if let jsonVal = json, let hits = jsonVal["hits"] as? [[String: Any]] {
                        if self?.totalImages == nil { self?.totalImages = jsonVal["totalHits"] as? Int }
                        
                        for each in hits {
                            self?.images.append(SelfieImageObject(json: each))
                        }
                        self?.imagesCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    func checkForPage(indexPath: IndexPath) {
        if let totalImages = totalImages, (indexPath.row + 20) < totalImages, indexPath.row <= self.images.count, indexPath.row == (self.images.count - 10) {
            self.page += 1
            self.loadData(page: page)
        }
    }
    
    func downloadImage(url: URL, cell: ImageCollectionViewCell, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil)
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(nil, error)
                    
                } else if let data = data, let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image, nil)
                } else {
                    completion(nil, error)
                }
                }.resume()
        }
    }
    
    
}

extension InstagramViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCollectionViewCell.self), for: indexPath) as? ImageCollectionViewCell {
            cell.imageView.image = UIImage(named: AppConstants.PLACEHOLDER_IMAGE)
            checkForPage(indexPath: indexPath)
            if let imageUrl = images[indexPath.row].imageUrl, let url = URL(string: imageUrl) {
                cell.startAnimation()
                self.downloadImage(url: url, cell: cell) { (image, error) in
                    cell.stopAnimation()
                    if error == nil {
                        DispatchQueue.main.async {
                            cell.imageView.image = image
                        }
                    }
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
    }
    
    
}

extension InstagramViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row % 3 == 0{
            return CGSize(width: (self.view.frame.width / 2) - 4, height: cellHeight)
        }
        return CGSize(width: (self.view.frame.width / 2) - 16, height: cellHeight / 2 - 16)
    }
    
    
}
