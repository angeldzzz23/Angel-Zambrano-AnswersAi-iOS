//
//  AppViewModel.swift
//  AppStore
//
//  Created by angel zambrano on 12/6/24.
//

import Foundation
import UIKit

//
enum AppAccess: CustomStringConvertible {
    
    case onStore(cost: Cost)

    var description: String {
        switch self {
        case .onStore(let cost):
            return cost.description
        }
    }
}

// being able to add the cost of make i free
enum Cost: CustomStringConvertible {
    case free
    case paid(cost: Float)

    var description: String {
        switch self {
        case .free:
            return "GET"
        case .paid(let cost):
            return "$\(cost)"
        }
    }

    static func cost(fromString string: String) -> Cost {
        if string.lowercased() == "free" {
            return .free
        }

        if let dollarSignIndex = string.firstIndex(of: "$") {
            var floatString = string
            floatString.remove(at: dollarSignIndex)
            let float = Float(floatString)
            return .paid(cost: float ?? 0.0)
        }

        return .paid(cost: 0.0)
    }
}

// we can modify the types of app view 
enum AppViewType {
    case horizontal
    case featured
    case none

    var imageSize: CGFloat {
        switch self {
        case .featured:
            return 40
        case .horizontal:
            return 50
        case .none:
            return 0
        }
    }

    var cornerRadius: CGFloat {
        return imageSize / 5
    }
}

class AppViewModel {
    let iconImage: UIImage
    let name: String
    let tagline: String
    let category: String
    let cost: Cost
    let appAccess: AppAccess
    let appViewType: AppViewType
    let mainTitle: String
    let subtitle: String

    init(name: String, tagline: String, category: String, cost: Cost, iconImage: UIImage, appViewType: AppViewType, mainTitle: String, subtitle: String) {
        self.iconImage = iconImage
        self.name = name
        self.tagline = tagline
        self.category = category
        self.cost = cost
        self.mainTitle = mainTitle
        self.subtitle = subtitle
        
        self.appAccess = .onStore(cost: cost)
        self.appViewType = appViewType
    }
}



