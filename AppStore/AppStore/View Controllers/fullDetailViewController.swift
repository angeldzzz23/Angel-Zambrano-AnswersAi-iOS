//
//  DetailView.swift
//  AppStore
//
//  Created by angel zambrano on 12/6/24.
//

import UIKit

// this is the viewcontroller that is presented
class fullDetailViewController: UIViewController, UIScrollViewDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: Views
    lazy var snapshotView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowRadius = 10.0
        imageView.layer.shadowOffset = CGSize(width: -1, height: 2)
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = true
        view.clipsToBounds = true
        return view
    }()
    
    private var downloadNowView = DownLoadNow(frame: .zero, cardViewModel: nil)
    
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewsAreHidden: Bool = false {
        didSet {
            closeButton.isHidden = viewsAreHidden
            cardView?.isHidden = viewsAreHidden
            textLabel.isHidden = viewsAreHidden

            view.backgroundColor = viewsAreHidden ? .clear : .white
        }
    }
    
    private let cardViewModel: CardViewModel
    private(set) var cardView: CardView?
    
    init(cardViewModel: CardViewModel) {
        self.cardViewModel = cardViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureView()
//        presentShareSheet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
        print("View deinit.")
    }
    
}

extension fullDetailViewController {
    
    func configureView() {
        configureScrollView()
        configureCardView()
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureDownloadNowView() {
        let cardModel = cardViewModel
        downloadNowView = DownLoadNow(frame: .zero, cardViewModel: cardModel)
        downloadNowView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(downloadNowView)

        NSLayoutConstraint.activate([
            downloadNowView.heightAnchor.constraint(equalToConstant: 200),
            downloadNowView.leftAnchor.constraint(equalTo: view.leftAnchor),
            downloadNowView.rightAnchor.constraint(equalTo: view.rightAnchor),
            downloadNowView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20.0),
            downloadNowView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
    }
    
    
    func configureCardView() {
        let appView = AppView(cardViewModel.app)
        let cardModel = cardViewModel
        cardViewModel.viewMode = .full
        cardView = CardView(cardModel: cardModel, appView: appView)
        cardView?.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(cardView!)
        
        let topPadding = UIWindow.topPadding
        
        NSLayoutConstraint.activate([
            cardView!.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -topPadding),
            cardView!.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            cardView!.heightAnchor.constraint(equalToConstant: 450),
            cardView!.widthAnchor.constraint(equalToConstant: view.frame.size.width)
        ])
        
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20.0),
            closeButton.widthAnchor.constraint(equalToConstant: 30.0),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor, multiplier: 1.0),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0)
        ])
        
        if cardView?.cardModel.backgroundType == .light {
            closeButton.setImage(UIImage(named: "darkOnLight")!, for: UIControl.State.normal)
        } else {
            closeButton.setImage(UIImage(named: "lightOnDark")!, for: UIControl.State.normal)
        }
        
        
        let firstString = "Lorem Ipsum is simply "
        let firstAttributes: [NSAttributedString.Key: Any] = [
            .font : UIFont.systemFont(ofSize: 20, weight: .medium),
            .foregroundColor: UIColor.black
        ]
        let firstAttributedString = NSMutableAttributedString(string: firstString, attributes: firstAttributes)
        
        let secondString = "dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\n\nIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\nContrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. \n\nLorem Ipsum comes from sections 1.10.32 and 1.10.33 of 'de Finibus Bonorum et Malorum' (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, 'Lorem ipsum dolor sit amet..', comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from 'de Finibus Bonorum et Malorum' by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham. Where can I get some? There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
        
        let secondAttributes: [NSAttributedString.Key: Any] = [
            .font : UIFont.systemFont(ofSize: 20, weight: .regular),
            .foregroundColor: UIColor.gray
        ]
        
        let secondAttributedString = NSMutableAttributedString(string: secondString, attributes: secondAttributes)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.2
        
        let attributedString = NSMutableAttributedString(attributedString: firstAttributedString)
        attributedString.append(secondAttributedString)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        textLabel.attributedText = attributedString
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        
        scrollView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            textLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width - 40),
            textLabel.topAnchor.constraint(equalTo: cardView!.bottomAnchor, constant: 20.0),
//
        ])
        
        
        // confitu
        configureDownloadNowView()
        
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    func createSnapshotOfView() {
        let snapshotImage = view.createSnapshot()
        snapshotView.image = snapshotImage
        scrollView.addSubview(snapshotView)
        
        let topPadding = UIWindow.topPadding
        snapshotView.frame = CGRect(x: 0, y: -topPadding, width: view.frame.size.width, height: view.frame.size.height)
        
        scrollView.delegate = self
    }
    
}

extension fullDetailViewController {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPositionForDismissal: CGFloat = 20.0
        var yContentOffset = scrollView.contentOffset.y
        let topPadding = UIWindow.topPadding
        
        yContentOffset += topPadding
        
        updateCloseButton(yContentOffset: yContentOffset)
        
        if scrollView.isTracking {
            scrollView.bounces = true
        } else {
            scrollView.bounces = yContentOffset > 500
        }
        
        if yContentOffset < 0 && scrollView.isTracking {
            viewsAreHidden = true
            snapshotView.isHidden = false
            
            let scale = (100 + yContentOffset) / 100
            snapshotView.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            snapshotView.layer.cornerRadius = -yContentOffset > yPositionForDismissal ? yPositionForDismissal : -yContentOffset
            
            if yPositionForDismissal + yContentOffset <= 0 {
                self.close()
            }
            
        } else {
            viewsAreHidden = false
            snapshotView.isHidden = true
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.bounces = true
    }
    
    func updateCloseButton(yContentOffset: CGFloat) {
        
        let topPadding = UIWindow.topPadding
        
        if yContentOffset < 450 - topPadding && cardView?.cardModel.backgroundType == .dark {
            closeButton.setImage(UIImage(named: "lightOnDark"), for: .normal)
        } else {
            closeButton.setImage(UIImage(named: "darkOnLight"), for: .normal)
        }
        
    }
    
//    private func presentShareSheet() {
//        guard let image = UIImage(systemName: "bell"), let url = URL(string: "https://wwww.google.com") else {return}
//        
//        let sharedSheetVC = UIActivityViewController(activityItems: [image, url], applicationActivities: nil)
//        present(sharedSheetVC, animated: true)
//    }

}
