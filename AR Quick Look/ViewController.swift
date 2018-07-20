//
//  ViewController.swift
//  AR QuickLook
//
//  Created by Piotr Sirek on 19/07/2018.
//  Copyright © 2018 Piotr Sirek. All rights reserved.
//

import UIKit
import Foundation
import QuickLook

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let models = ["wheelbarrow", "wateringcan", "teapot", "gramophone", "cupandsaucer", "redchair", "tulip", "plantpot"]
    
    var thumbnails = [UIImage]()
    var thumbnailIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for model in models {
            if let thumbnail = UIImage(named: "\(model).jpg") {
                thumbnails.append(thumbnail)
            }
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCell", for: indexPath) as? LibraryCollectionViewCell
        
        if let cell = cell {
            cell.modelThumbnail.image = thumbnails[indexPath.row]
            let title = models[indexPath.row]
            cell.modelTitle.text = title.capitalized
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        thumbnailIndex = indexPath.item
        
        let previewController = QLPreviewController()
        previewController.delegate = self
        previewController.dataSource = self
        present(previewController, animated: true)
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let url = Bundle.main.url(forResource: models[thumbnailIndex], withExtension: "usdz")!
        return url as QLPreviewItem
    }

}

