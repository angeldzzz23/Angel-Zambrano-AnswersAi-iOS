//
//  DownLoadNow.swift
//  AppStore
//
//  Created by angel zambrano on 12/7/24.
//

import UIKit

// this is the download now portion
class DownLoadNow: UIView {
    
    private var imageICon:  UIImageView = {
        let imgview = UIImageView()
        imgview.translatesAutoresizingMaskIntoConstraints = false
        imgview.contentMode = .scaleAspectFit
        return imgview
    }()
    
    private let appName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Apple"
        label.font = UIFont.boldSystemFont(ofSize: 24) // Set the font and size
        label.textColor = .black // Set the text color
        label.textAlignment = .center // Center the text
        return label
    }()
    
    
    private var cardViewModel: CardViewModel?
    
    init(frame: CGRect, cardViewModel: CardViewModel?) {
            self.cardViewModel = cardViewModel
            super.init(frame: frame)
           // Call the setup function

            
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: add constants later
    private func configureImageIcon() {
        guard let icon = cardViewModel?.app?.iconImage else {return}
        self.addSubview(imageICon)
        imageICon.image = icon
        NSLayoutConstraint.activate([
            imageICon.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageICon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageICon.widthAnchor.constraint(equalToConstant: 60),
            imageICon.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func configureAppName() {
        self.addSubview(appName)
        appName.text = "helo world"
//            
        NSLayoutConstraint.activate([
            appName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            appName.topAnchor.constraint(equalTo: imageICon.bottomAnchor
                      )
        ])

    }

    // add the set up view
    private func setupView() {
        backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        configureImageIcon()
        configureAppName()

    }
    
}
