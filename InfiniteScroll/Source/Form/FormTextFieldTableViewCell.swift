//
//  FormTextFieldTableViewCell.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 02/10/22.
//

import UIKit

class FormTextFieldTableViewCell: UITableViewCell, FormConformity {
    
    lazy var ibTextField:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title *"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    var formItem: FormItem?

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
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        self.formItem?.valueCompletion?(textField.text)
    }
    
}

extension FormTextFieldTableViewCell: ViewCode {
    func setupHierarchy() {
        contentView.addSubview(ibTextField)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupConfiguration() {
        // implement
    }
}

// MARK: - FormUpdatable
extension FormTextFieldTableViewCell: FormUpdatable {
    func update(with formItem: FormItem) {
        self.formItem = formItem
        
        self.ibTextField.text = self.formItem?.value
        
        let bgColor: UIColor = self.formItem?.isValid  == false ? .red : .white
        self.ibTextField.layer.backgroundColor = bgColor.cgColor
        self.ibTextField.placeholder = self.formItem?.placeholder
        self.ibTextField.keyboardType = self.formItem?.uiProperties.keyboardType ?? .default
        self.ibTextField.tintColor = self.formItem?.uiProperties.tintColor
    }
}
