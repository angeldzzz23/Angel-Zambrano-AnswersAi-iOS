//
//  AppView.swift
//  AppStore
//
//  Created by angel zambrano on 12/6/24.
//


import UIKit

class AppView: UIView {
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = backgroundType.titleTextColor
        
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = backgroundType.subtitleTextColor

        return label
    }()
    
    lazy var buttonSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = backgroundType.subtitleTextColor
        return label
    }()
    
    lazy var getButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var labelsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    lazy var bottomDetails: UIView = {
        let sv = UIView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .purple
        return sv
    }()
    
    private let appViewType: AppViewType
    var viewModel: AppViewModel
    
    var backgroundType: BackgroundType = .light {
        didSet {
            titleLabel.textColor = backgroundType.titleTextColor
            subtitleLabel.textColor = backgroundType.subtitleTextColor
            buttonSubtitleLabel.textColor = backgroundType.subtitleTextColor
        }
    }
 
    init?(_ viewModel: AppViewModel?) {
        guard let viewModel = viewModel else { return nil }
        self.viewModel = viewModel
        self.appViewType = viewModel.appViewType
        super.init(frame: .zero)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        configureViews()
        configureLabelsView()
        backgroundColor = .clear
        
        switch appViewType {
        case .featured: //
            addFeaturedTopViews()
        case .horizontal:
            break
        case .none:
            break
        }
    }
    
    func configureViews() {
        iconImageView.configureAppIconView(forImage: viewModel.iconImage, size: appViewType.imageSize)
//        
        titleLabel.configureAppHeaderLabel(withText: viewModel.name)
//        
        subtitleLabel.configureAppSubHeaderLabel(withText: viewModel.category.description.uppercasedFirstLetter)
//        
        buttonSubtitleLabel.configureTinyLabel(withText: "In-App Purchases")
//        
        getButton.roundedActionButton(withText: viewModel.appAccess.description)
    }
    
    func configureLabelsView() {
        
        labelsView.addSubview(subtitleLabel)
        
        
        NSLayoutConstraint.activate([
            subtitleLabel.leftAnchor.constraint(equalTo: labelsView.leftAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: labelsView.bottomAnchor),
            subtitleLabel.widthAnchor.constraint(equalTo: labelsView.widthAnchor)
        ])
        
        labelsView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: labelsView.leftAnchor),
            titleLabel.widthAnchor.constraint(equalTo: labelsView.widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: labelsView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -2.0)
            
        ])
        
    }
    
    
    
    fileprivate func addHorizontalLabelsAndButton() {
        addSubview(bottomDetails)
        addSubview(labelsView)
        addSubview(getButton)
        addSubview(iconImageView)
        
    }
    
    fileprivate func configureHorizontalLabelsAndButton() {
        
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: appViewType.imageSize),
            iconImageView.widthAnchor.constraint(equalToConstant: appViewType.imageSize),
            
            bottomDetails.leftAnchor.constraint(equalTo: self.leftAnchor),
            bottomDetails.rightAnchor.constraint(equalTo: self.rightAnchor),
            bottomDetails.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomDetails.heightAnchor.constraint(equalToConstant: 70),
            iconImageView.leftAnchor.constraint(equalTo: bottomDetails.leftAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: bottomDetails.centerYAnchor),
            


            labelsView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            labelsView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),

            getButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            getButton.centerYAnchor.constraint(equalTo: self.bottomDetails.centerYAnchor),
            getButton.widthAnchor.constraint(equalToConstant: 76.0)
        ])
        
    }
    
    fileprivate func addPurchaseAvailableLabelIfNeeded() {
        
        if viewModel.hasInAppPurchase && buttonSubtitleLabel.superview == nil {
            addSubview(buttonSubtitleLabel)
            
            NSLayoutConstraint.activate([
                buttonSubtitleLabel.centerXAnchor.constraint(equalTo: getButton.centerXAnchor),
                buttonSubtitleLabel.topAnchor.constraint(equalTo: getButton.bottomAnchor, constant: 3.0)
            ])
        }

        if viewModel.hasInAppPurchase == true {
            buttonSubtitleLabel.isHidden = (viewModel.isOnDevice == true || viewModel.alreadyPurchased == true) ? true : false
        } else {
            buttonSubtitleLabel.isHidden = true
        }
        
    }
    
}

extension AppView {
    
    fileprivate func addFeaturedTopViews() {
        addHorizontalLabelsAndButton()
        configureHorizontalLabelsAndButton()
        configureFeaturedTopViews()
    }
    
    // modified the topt one
    fileprivate func configureFeaturedTopViews() {
        configureHorizontalLabelsAndButton()
    }
    
    func configure(with viewModel: AppViewModel) {
        self.viewModel = viewModel
        configureViews()
        
    }
    
}


