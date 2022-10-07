//
//  HeaderCell.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 30/09/22.
//

import UIKit

class HeaderCell: UICollectionReusableView {

    var section: Int?
    
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Halvetica", size: 17)
        label.textColor = .red
        return label
    }()

    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Test button", for: .normal)
        button.addTarget(HeaderCell.self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didTapButton() {
        guard let section = self.section else {
            return
        }
        debugPrint(#function, #line, section)
    }
}

// MARK: ViewCode

extension HeaderCell: ViewCode {
    func setupHierarchy() {
        addSubview(label)
        addSubview(button)
    }
    
    func setupConstraints() {        
        let views = ["label": label, "button": button, "view": self]
        let horizontallayoutContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[label]-[button]-15-|", options: .alignAllCenterY, metrics: nil, views: views)
        self.addConstraints(horizontallayoutContraints)
        let verticalLayoutContraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(verticalLayoutContraint)
    }
    
    func setupConfiguration() {
        guard let section = self.section else {
            return
        }
        label.text="Products section \(section)"
    }
    
}
