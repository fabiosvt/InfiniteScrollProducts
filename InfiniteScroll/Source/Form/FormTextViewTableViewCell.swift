//
//  FormTextViewTableViewCell.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 02/10/22.
//

import UIKit

class FormTextViewTableViewCell: UITableViewCell, FormConformity {
    
    @IBOutlet weak var ibTextField: UITextField!
    
    var formItem: FormItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.ibTextField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        self.formItem?.valueCompletion?(textField.text)
    }
    
}

// MARK: - FormUpdatable
extension FormTextViewTableViewCell: FormUpdatable {
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
