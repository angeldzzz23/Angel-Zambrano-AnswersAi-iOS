//
//  GenericTableViewCell.swift
//  AppStore
//
//  Created by angel zambrano on 12/6/24.
//

import Foundation

import UIKit
// basic empty table view cell
class GenericTableViewCell<View: UIView>: UITableViewCell {
  
    var cellView: View? {
        didSet {
            guard cellView != nil else { return }
            setUpViews()
        }
    }
    
    private func setUpViews() {
        guard let cellView = cellView else { return }
        
        addSubview(cellView)
        cellView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
