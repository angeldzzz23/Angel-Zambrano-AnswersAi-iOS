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
    
    lazy var bottomGradientView: UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.backgroundColor = .clear
           return view
       }()

    
    private func addGradientToBottomDetails() {
           // Ensure we only add the gradient if we haven't already
           guard bottomDetails.layer.sublayers?.first(where: { $0 is CAGradientLayer }) == nil else { return }
           
           let gradientLayer = CAGradientLayer()
           gradientLayer.colors = [
               UIColor.clear.cgColor,
               UIColor.darkGray.cgColor
           ]
           gradientLayer.locations = [0.3, 1.0] // Start the gradient earlier
           gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
           gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
           
           // Set the initial frame to match the bottomDetails view
           gradientLayer.frame = bottomDetails.bounds
           
           // Insert the gradient layer at the bottom of the layer stack
           bottomDetails.layer.insertSublayer(gradientLayer, at: 0)
       }

    
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
        sv.backgroundColor = .black
        sv.isOpaque = true
        sv.alpha = 0.09
        return sv
    }()
    
    private let appViewType: AppViewType
    var viewModel: AppViewModel
    
    var backgroundType: BackgroundType = .light {
        didSet {
            titleLabel.textColor = backgroundType.titleTextColor
            subtitleLabel.textColor = backgroundType.subtitleTextColor
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
        
        titleLabel.configureAppHeaderLabel(withText: viewModel.name + ":" + viewModel.tagline)

        subtitleLabel.configureAppSubHeaderLabel(withText: viewModel.category.description.uppercasedFirstLetter)
        

        
        getButton.roundedActionButton(withText: viewModel.appAccess.description)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let effectView = bottomGradientView.subviews.first(where: { $0 is UIVisualEffectView }) as? UIVisualEffectView {
               effectView.frame = bottomGradientView.bounds
               
               // Update the gradient layer mask
               if let gradientLayer = effectView.layer.mask as? CAGradientLayer {
                   gradientLayer.frame = effectView.bounds
               }
           }
        
    }
    
    // configured top and  bottom label inside of a parent view
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
        addSubview(bottomGradientView) // Add this line
        addSubview(bottomDetails)
        addSubview(labelsView)
        addSubview(getButton)
        addSubview(iconImageView)
        
    }
    
    fileprivate func configureHorizontalLabelsAndButton() {
        
        
        NSLayoutConstraint.activate([
            bottomGradientView.leftAnchor.constraint(equalTo: self.leftAnchor),
                      bottomGradientView.rightAnchor.constraint(equalTo: self.rightAnchor),
            bottomGradientView.bottomAnchor.constraint(equalTo: bottomDetails.bottomAnchor),
                      bottomGradientView.heightAnchor.constraint(equalToConstant:200), // Adjust height as needed
            
            iconImageView.heightAnchor.constraint(equalToConstant: appViewType.imageSize),
            iconImageView.widthAnchor.constraint(equalToConstant: appViewType.imageSize),
            
            bottomDetails.leftAnchor.constraint(equalTo: self.leftAnchor),
            bottomDetails.rightAnchor.constraint(equalTo: self.rightAnchor),
            bottomDetails.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomDetails.heightAnchor.constraint(equalToConstant: 75),
            iconImageView.leftAnchor.constraint(equalTo: bottomDetails.leftAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: bottomDetails.centerYAnchor),
            


            labelsView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            labelsView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),

            getButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            getButton.centerYAnchor.constraint(equalTo: self.bottomDetails.centerYAnchor),
            getButton.widthAnchor.constraint(equalToConstant: 76.0)
        ])
        
    }
    
    
    private func addBlurToBottomGradientView() {
        // Ensure we only add the blur if we haven't already
        guard bottomGradientView.subviews.first(where: { $0 is UIVisualEffectView }) == nil else { return }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.white.withAlphaComponent(1).cgColor
        ]
        
        let viewEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: viewEffect)
        
        // Position the effect view to cover the bottom of the view
        effectView.frame = CGRect(
            x: bottomGradientView.bounds.origin.x,
            y: 0,
            width: bottomGradientView.bounds.width,
            height: bottomGradientView.bounds.height
        )
        
        gradientLayer.frame = effectView.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.3)
        
        effectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        effectView.layer.mask = gradientLayer
        effectView.isUserInteractionEnabled = false
        
        bottomGradientView.addSubview(effectView)
    }
    
    
}

extension AppView {
    
    fileprivate func addFeaturedTopViews() {
        addHorizontalLabelsAndButton()
        configureHorizontalLabelsAndButton()
        addBlurToBottomGradientView() // Add this line


        
    }
    
    func configure(with viewModel: AppViewModel) {
        self.viewModel = viewModel
        configureViews()
    }
    
}


