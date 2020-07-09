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
  override func viewDidLoad() {
    super.viewDidLoad()
    populatePhotots()
  }
  
  private func populatePhotots() {
    PHPhotoLibrary.requestAuthorization { status in
      if status == .authorized {
        
      }
    }
  }
}
