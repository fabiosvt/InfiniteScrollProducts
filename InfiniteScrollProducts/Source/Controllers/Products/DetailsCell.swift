//
//  DetailsCell.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 30/09/22.
//

import UIKit

class DetailsCell: UICollectionViewCell {

    var product: Product?
    
    weak var delegate: ViewControllerDelegate?

    static let reuseIdentifier = "DetailsCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        label.textAlignment = .center
        return label
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Test button", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
        self.backgroundColor = .red
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    

    @objc func didTapButton() {
        guard let product = product else { return }
        delegate?.didTapProductDetailButton(product: product)
    }
}

// MARK: ViewCode

extension DetailsCell: ViewCode {
    func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(label)
        contentView.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            label.leftAnchor.constraint(equalTo: leftAnchor),

            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            button.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func setupConfiguration() {
        guard let product = product else { return }
        titleLabel.text = "section: row: "
        label.text = product.title
    }
    
}
