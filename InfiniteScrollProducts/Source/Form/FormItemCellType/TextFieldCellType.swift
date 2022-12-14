//
//  TextFieldCellType.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 02/10/22.
//

import UIKit

class TextFieldCellType: UITableViewCell, FormConformity {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField:UITextField = {
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
        textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .allEditingEvents)
        return textField
    }()
    
    var formItem: FormItem?

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

extension TextFieldCellType: ViewCode {
    func setupHierarchy() {
        contentView.addSubview(label)
        contentView.addSubview(textField)
    }
    
    func setupConstraints() {
        
        let viewsDict = [
            "label": label,
            "textField": textField
        ]

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label]-[textField]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[textField]-|", options: [], metrics: nil, views: viewsDict))
    }
    
    func setupConfiguration() {
        label.text = formItem?.label
    }
}

// MARK: - FormUpdatable
extension TextFieldCellType: FormUpdatable {
    func update(with formItem: FormItem) {
        self.formItem = formItem
        self.label.text = self.formItem?.label
        switch self.formItem?.uiProperties.cellType {
        case .textField:
            if let value = self.formItem?.value as? String {
                self.textField.text = value
            }
        case .intField:
            if let value = self.formItem?.value as? Int {
                self.textField.text = "\(value)"

            }
        case .doubleField:
            if let value = self.formItem?.value as? Double {
                self.textField.text = "\(value)"
            }
        default:
            if let value = self.formItem?.value as? String {
                self.textField.text = value
            }
        }
        let bgColor: UIColor = self.formItem?.isValid  == false ? .red : .white
        self.textField.layer.backgroundColor = bgColor.cgColor
        self.textField.placeholder = self.formItem?.placeholder
        self.textField.keyboardType = self.formItem?.uiProperties.keyboardType ?? .default
        self.textField.tintColor = self.formItem?.uiProperties.tintColor
    }
}
