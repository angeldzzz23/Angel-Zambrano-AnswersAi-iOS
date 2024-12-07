//
//  DownLoadNow.swift
//  AppStore
//
//  Created by angel zambrano on 12/7/24.
//

import UIKit

// this is the download now portion
class DownLoadNow: UIView {
    
   
    
    private let appdescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Download Now"
        label.font = UIFont.boldSystemFont(ofSize: 24) // Set the font and size
        label.textColor = .white // Set the text color
        label.textAlignment = .center // Center the text
        return label
    }()
    
    
    private var cardViewModel: CardViewModel?
    
    init(frame: CGRect, cardViewModel: CardViewModel?) {
            self.cardViewModel = cardViewModel
            super.init(frame: frame)
            setupView() // Call the setup function

            
        }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
    }
    
}
