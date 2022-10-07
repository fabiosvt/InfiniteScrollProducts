//
//  CustomCollectionViewCell.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 11/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    var myLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        myLabel.textColor = .black
        myLabel.textAlignment = .center
        myLabel.font = .systemFont(ofSize: 14.0)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(myLabel)
        
        let g = contentView
        NSLayoutConstraint.activate([
            
            myLabel.leadingAnchor.constraint(greaterThanOrEqualTo: g.leadingAnchor, constant: 4.0),
            myLabel.trailingAnchor.constraint(lessThanOrEqualTo: g.trailingAnchor, constant: -4.0),
            myLabel.centerXAnchor.constraint(equalTo: g.centerXAnchor),
            myLabel.centerYAnchor.constraint(equalTo: g.centerYAnchor),

        ])
    }
    
}
