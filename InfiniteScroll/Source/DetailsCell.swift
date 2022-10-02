//
//  DetailsCell.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 30/09/22.
//

import UIKit

protocol DetailsViewDelegate: AnyObject {
    func goToProductDetail(didSelect infiniteProduct: Product)
}

class DetailsCell: UITableViewCell {
    var model : CellModel?

    weak var delegate : DetailsViewDelegate?

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
        button.addTarget(self, action: #selector(visibleRow), for: .touchUpInside)
        return button
    }()
    
    func setup() {
        setupHierarchy()
        setupConstraints()
        setupConfiguration()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func visibleRow() {
        guard let model = model else { return }
        delegate?.goToProductDetail(didSelect: model.item)
    }
}

extension DetailsCell: ViewCode {
    func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(label)
        contentView.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            label.heightAnchor.constraint(equalToConstant: 30),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),

            button.heightAnchor.constraint(equalToConstant: 30),
            button.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupConfiguration() {
        guard let model = model else { return }
        titleLabel.text = "section: \(model.indexPath.section) row: \(model.indexPath.row)"
        label.text = model.item.title
    }
    
}
