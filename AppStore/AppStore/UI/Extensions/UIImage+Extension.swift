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
    
}
