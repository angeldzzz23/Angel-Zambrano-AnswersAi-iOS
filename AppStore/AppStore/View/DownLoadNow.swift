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
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .black // Set the text color
        label.textAlignment = .center // Center the text
        return label
    }()
    
    // adding app description
    private let appDescription: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text =  "Home of Apple TV+ and more"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //
    private let downloadButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.down.circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
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
            imageICon.widthAnchor.constraint(equalToConstant: 75),
            imageICon.heightAnchor.constraint(equalToConstant: 75),
        ])
    }
    
    private func configureAppDescription() {
        self.addSubview(appDescription)
        NSLayoutConstraint.activate([
            appDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            appDescription.topAnchor.constraint(equalTo: appName.bottomAnchor, constant: 7)
        ])
        
    }
    
    private func configureAppName() {
        self.addSubview(appName)
        
        appName.text = "Apple"
        
        NSLayoutConstraint.activate([
            appName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            appName.topAnchor.constraint(equalTo: imageICon.bottomAnchor, constant: 7),
        ])
    }

    private func configureDownloadButton() {
        self.addSubview(downloadButton)
        downloadButton.imageView?.contentMode = .scaleAspectFit // Ensure the image scales with the button
        downloadButton.contentHorizontalAlignment = .fill
        downloadButton.contentVerticalAlignment = .fill
        
        NSLayoutConstraint.activate([
            downloadButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: appDescription.bottomAnchor, constant: 15),
            downloadButton.widthAnchor.constraint(equalToConstant: 25), // Set width
            downloadButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    // add the set up view
    private func setupView() {
        backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        configureImageIcon()
        configureAppName()
        configureAppDescription()
        configureDownloadButton()

    }
    
}
