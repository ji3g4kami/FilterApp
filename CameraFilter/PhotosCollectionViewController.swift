//
//  PhotosCollectionViewController.swift
//  CameraFilter
//
//  Created by 登秝吳 on 09/07/2020.
//  Copyright © 2020 登秝吳. All rights reserved.
//

import Foundation
import UIKit
import Photos

final class PhotosCollectionViewController: UICollectionViewController {
  
  private var images = [PHAsset]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    populatePhotots()
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
    let asset = images[indexPath.row]
    let manager = PHImageManager.default()
    manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { image, _ in
      DispatchQueue.main.async {
        cell.photoImageView.image = image
      }
    }
    
    return cell
  }
  
  private func populatePhotots() {
    PHPhotoLibrary.requestAuthorization { status in
      if status == .authorized {
        
        let assests = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        assests.enumerateObjects { [unowned self] object, count, stop in
          self.images.append(object)
        }
        
        self.images.reverse()
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    }
  }
}
