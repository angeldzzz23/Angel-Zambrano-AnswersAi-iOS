//
//  CardsData.swift
//  AppStore
//
//  Created by angel zambrano on 12/6/24.
//

import Foundation
import UIKit

// adding the cards data
// parsing the data from json
class CardsData {
    
    static let instance = CardsData()
    
    class var shared: CardsData {
        return instance
    }
    
    let json: [String: Any]
    
    var cards: [CardViewModel] {
        return parseCards(forJSON: json)
    }
    
    init() {
        guard let cardsURL = Bundle.main.url(forResource: "CardsData", withExtension: "json") else {
            json = [:]
            return
        }
        
        do {
            let cardsData = try Data(contentsOf: cardsURL)
            if let cardsJson = try JSONSerialization.jsonObject(with: cardsData, options: JSONSerialization.ReadingOptions()) as? [String: Any] {
                json = cardsJson
            } else {
                json = [:]
                print("[LOG] Error parsing CardsData.json data")
            }
        } catch {
            json = [:]
            print("[LOG] Error parsing .json data")
        }
    }
    
    // MARK: - Parse Apps -
    func parseApp(for JSON: [String: String], viewType: AppViewType) -> AppViewModel? {
        guard let name = JSON["name"],
            let tagline = JSON["tagline"],
            let categoryString = JSON["category"],
            let cost = JSON["cost"],
            let iconName = JSON["iconName"],
            let image = UIImage(named: iconName),
              let mainTitle = JSON["main-title"],
              let subTitle = JSON["sub-title"]
                
            else
        { return nil }
      
        
        return AppViewModel(name: name, tagline: tagline, category: categoryString, cost:  Cost.cost(fromString: cost), iconImage: image, appViewType: viewType, mainTitle: mainTitle, subtitle: subTitle)
     
    }
    
    // MARK: - Parse Cards -
    func parseCards(forJSON json: [String: Any]) -> [CardViewModel] {
        guard let cardsData = json["cardTiles"] as? [[String: Any]] else { return [] }
        
        let cards = cardsData.compactMap({ (cardsDictionary) -> CardViewModel? in
            
            guard let cardTypeString = cardsDictionary["type"] as? String else { return nil }
          
            let bgImageString = cardsDictionary["backgroundImage"] as? String
            let bgTypeString = cardsDictionary["backgroundType"] as? String
            let bgType = BackgroundType(rawValue: bgTypeString ?? "")
            
            
            let apps = cardsDictionary["apps"] as? [[String: String]]
          
            switch cardTypeString {
            case "featured":
                guard let bgImage = UIImage(named: bgImageString ?? "card1"),
                    let app = apps?.first,
                    let appViewModel = parseApp(for: app, viewType: AppViewType.featured) else { break }
                
                let cardType = CardViewType.appOfTheDay(bgImage: bgImage, bgType: bgType, app: appViewModel)
                return CardViewModel(viewType: cardType)
            default:
                return nil
          }
          
          return nil
            
        })
        
        return cards
        
    }
    
}
