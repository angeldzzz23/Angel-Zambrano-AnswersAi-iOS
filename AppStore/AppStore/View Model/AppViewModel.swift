//
//  AppViewModel.swift
//  AppStore
//
//  Created by angel zambrano on 12/6/24.
//

import Foundation
import UIKit

enum AppAccess: CustomStringConvertible {
    case onCloud
    case onDevice
    case onStore(cost: Cost)

    var description: String {
        switch self {
        case .onCloud:
            return "detail_download"
        case .onDevice:
            return "OPEN"
        case .onStore(let cost):
            return cost.description
        }
    }
}

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

    init(name: String, tagline: String, category: String, cost: Cost, iconImage: UIImage, appViewType: AppViewType) {
        self.iconImage = iconImage
        self.name = name
        self.tagline = tagline
        self.category = category
        self.cost = cost
        
        self.appAccess = false ? (false ? .onDevice : .onCloud) : .onStore(cost: cost)
        self.appViewType = appViewType
    }
}



