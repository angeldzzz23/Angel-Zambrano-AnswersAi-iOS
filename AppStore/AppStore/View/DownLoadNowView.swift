//
//  DownLoadNow.swift
//  AppStore
//
//  Created by angel zambrano on 12/7/24.
//

import UIKit

// this is the download now portion

class DownLoadNowView: UIView {
    

    private var imageICon: UIImageView = {
        let imgview = UIImageView()
        imgview.translatesAutoresizingMaskIntoConstraints = false
        imgview.contentMode = .scaleAspectFit
        return imgview
    }()

    private let appName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .black // Set the text color
        label.textAlignment = .center // Center the text
        return label
    }()

    private let appDescription: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text = "Home of Apple TV+ and more"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let downloadButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.down.circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()

    private var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()

    private var cardViewModel: CardViewModel?

    init(frame: CGRect, cardViewModel: CardViewModel?) {
        self.cardViewModel = cardViewModel
        super.init(frame: frame)
        configureUIWithContent()
    }

    private func configureUIWithContent() {
        guard let name = cardViewModel?.app?.name else { return }
        appName.text = name
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureImageIcon() {
        guard let icon = cardViewModel?.app?.iconImage else { return }
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

    @objc private func downloadButtonTapped() {
        // Start the loading animation
        startLoading()

        // Simulate a 10-second download process
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.stopLoading()
        }
    }

    private func startLoading() {
        // Hide the button image and show the activity indicator
        downloadButton.setImage(nil, for: .normal)
        downloadButton.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: downloadButton.bounds.midX, y: downloadButton.bounds.midY)
        activityIndicator.startAnimating()
    }

    private func stopLoading() {
        // Stop the activity indicator and restore the button image
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        downloadButton.setImage(UIImage(systemName: "arrow.down.circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }

    private func configureAppName() {
        self.addSubview(appName)
        NSLayoutConstraint.activate([
            appName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            appName.topAnchor.constraint(equalTo: imageICon.bottomAnchor, constant: 7),
        ])
    }

    private func configureDownloadButton() {
        self.addSubview(downloadButton)
        downloadButton.addSubview(activityIndicator)
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
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

    private func setupView() {
        backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        configureImageIcon()
        configureAppName()
        configureAppDescription()
        configureDownloadButton()
    }
}
