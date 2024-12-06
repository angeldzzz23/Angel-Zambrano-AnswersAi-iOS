//
//  UIView+Extension.swift
//  AppStore
//
//  Created by angel zambrano on 12/6/24.
//

import UIKit

extension UIView {
    
    func createSnapshot() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
        drawHierarchy(in: frame, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
