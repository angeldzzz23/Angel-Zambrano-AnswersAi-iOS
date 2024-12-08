//
//  CardViewModel.swift
//  AppStore
//
//  Created by angel zambrano on 12/6/24.
//

import Foundation
import UIKit


enum CardViewMode {
    case full
    case card
}

enum CardViewType {
    case appOfTheDay(bgImage: UIImage, bgType: BackgroundType?, app: AppViewModel)
    
  
    var backgroundImage: UIImage? {
        switch self {
        case .appOfTheDay(let bgImage, _, _):
            return bgImage
        default:
            return nil
        }
    }
}

class CardViewModel {
  
    var viewMode: CardViewMode = .card
    let viewType: CardViewType
    var title: String? = nil
    var subtitle: String? = nil
    var description: String? = nil
    var app: AppViewModel? = nil
    var appCollection: [AppViewModel]? = nil
    var backgroundImage: UIImage? = nil
    var backgroundType: BackgroundType = .light // default to light
  
    init(viewType: CardViewType) {
        self.viewType = viewType
        switch viewType {
       
        case .appOfTheDay(let bgImage, let bgType, let app):
            self.backgroundImage = bgImage.imageWith(newSize: CGSize(width: 375, height: 450))
            self.app = app
            self.backgroundType = bgType ?? .light
      
        }
    }
}

