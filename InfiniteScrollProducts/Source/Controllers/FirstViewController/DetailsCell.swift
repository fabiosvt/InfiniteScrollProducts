//
//  DetailsCell.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 30/09/22.
//

import UIKit

class DetailsCell: UICollectionViewCell {

    var product: Product?
    var field: String?
    var title: String?
    var value: String?

    weak var delegate: FirstViewControllerDelegate?

    static let reuseIdentifier = "DetailsCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        label.textAlignment = .center
        return label
    }()
    
    private let valueLabel: UILabel = {
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
        guard let product = product else {
            return
        }
        delegate?.didTapProductDetailButton(product: product)
    }
}

// MARK: ViewCode

extension DetailsCell: ViewCode {
    func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),

            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            valueLabel.leftAnchor.constraint(equalTo: leftAnchor),

            button.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 12),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func setupConfiguration() {
        guard let product = product, let field = field, let titleValue = product.value(for: field) else {
            return
        }
        titleLabel.text = field
        valueLabel.text = "\(titleValue)"
    }
    
}
