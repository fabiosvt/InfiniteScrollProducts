//
//  TextViewCellType.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 02/10/22.
//

import UIKit

class TextViewCellType: UITableViewCell, FormConformity {
    
    @IBOutlet weak var textField: UITextField!
    
    var formItem: FormItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        self.formItem?.valueCompletion?(textField.text)
    }
    
}

// MARK: - FormUpdatable
extension TextViewCellType: FormUpdatable {
    func update(with formItem: FormItem) {
        self.formItem = formItem
        
        self.textField.text = self.formItem?.value
        
        let bgColor: UIColor = self.formItem?.isValid  == false ? .red : .white
        self.textField.layer.backgroundColor = bgColor.cgColor
        self.textField.placeholder = self.formItem?.placeholder
        self.textField.keyboardType = self.formItem?.uiProperties.keyboardType ?? .default
        self.textField.tintColor = self.formItem?.uiProperties.tintColor
    }
}
