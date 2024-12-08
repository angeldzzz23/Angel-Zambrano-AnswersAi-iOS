//
//  UIView+Extension.swift
//  AppStore
//
//  Created by angel zambrano on 12/6/24.
//

import UIKit

extension UIView {
    
    /// Creates a snapshot image of the view's current state.
    func createSnapshot() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
        drawHierarchy(in: frame, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
