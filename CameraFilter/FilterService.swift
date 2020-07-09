//
//  FilterService.swift
//  CameraFilter
//
//  Created by 登秝吳 on 09/07/2020.
//  Copyright © 2020 登秝吳. All rights reserved.
//

import Foundation
import UIKit
import CoreImage
import RxSwift

class FilterService {
  private var context: CIContext = CIContext()
  
  func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
    return Observable<UIImage>.create { observer in
      self.applyFilter(to: inputImage) { filteredImage in
        observer.onNext(filteredImage)
      }
      return Disposables.create()
    }
  }
  
  func applyFilter(to inputImage: UIImage, completion: @escaping (UIImage) -> Void) {
    let filter = CIFilter(name: "CICMYKHalftone")!
    filter.setValue(5.0, forKey: kCIInputWidthKey)
    
    let sourceImage = CIImage(image: inputImage)!
    filter.setValue(sourceImage, forKey: kCIInputImageKey)
    if let cgImage = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
      let processedImage = UIImage(cgImage: cgImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
      completion(processedImage)
    }
  }
  
}
