//
//  UIImage+Extension.swift
//  AppStore
//
//  Created by angel zambrano on 12/6/24.
//

import UIKit

extension UIImage {
    
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size:newSize)
        let image = renderer.image { _ in
            draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }

        return image
    }
    
    func resizeImage(to size: CGSize) -> UIImage? {
          UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
          self.draw(in: CGRect(origin: .zero, size: size))
          let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
          return resizedImage
      }
}

