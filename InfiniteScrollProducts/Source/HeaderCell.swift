//
//  HeaderCell.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 30/09/22.
//

import UIKit

class HeaderCell: UIView {

    let section: Int
    
    private var container: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        button.addTarget(HeaderCell.self, action: #selector(visibleHeader), for: .touchUpInside)
        return button
    }()
    
    init(section: Int) {
        self.section = section
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func visibleHeader() {
        debugPrint(#function, #line, section)
    }
}

extension HeaderCell: ViewCode {
    func setupHierarchy() {
        self.addSubview(container)
        container.addSubview(label)
        container.addSubview(button)
    }
    
    func setupConstraints() {        
        let views = ["label": label, "button": button, "view": container]
        let horizontallayoutContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[label]-[button]-15-|", options: .alignAllCenterY, metrics: nil, views: views)
        container.addConstraints(horizontallayoutContraints)
        let verticalLayoutContraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0)
        container.addConstraint(verticalLayoutContraint)
    }
    
    func setupConfiguration() {
        label.text="Products section \(self.section)"
    }
    
}
