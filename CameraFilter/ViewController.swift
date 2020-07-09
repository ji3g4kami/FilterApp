//
//  ViewController.swift
//  CameraFilter
//
//  Created by 登秝吳 on 09/07/2020.
//  Copyright © 2020 登秝吳. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var applyFilterButton: UIButton!
  
  let disposBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let navigationContoller = segue.destination as? UINavigationController,
      let photosCollectionVC = navigationContoller.viewControllers.first as? PhotosCollectionViewController else {
        fatalError("Segue destination not found")
    }
    photosCollectionVC.selectedPhoto.subscribe(onNext: { [unowned self] photo in
      self.updateUI(with: photo)
    })
    .disposed(by: disposBag)
  }
  
  @IBAction func applyFilterButtonPressed() {
    guard let sourceImage = photoImageView.image else {
      return
    }
    
    FilterService().applyFilter(to: sourceImage) { filteredImage in
      DispatchQueue.main.async {
        self.photoImageView.image = filteredImage
      }
    }
  }
  
  private func updateUI(with image: UIImage) {
    DispatchQueue.main.async {
      self.photoImageView.image = image
      self.applyFilterButton.isHidden = false
    }
  }
  
}

