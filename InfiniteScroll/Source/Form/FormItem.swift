//
//  FormItem.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 02/10/22.
//

import Foundation

/// ViewModel to display and react to text events, to update data
class FormItem: FormValidable {
    var value: String?
    var placeholder = ""
    var indexPath: IndexPath?
    var valueCompletion: ((String?) -> Void)?
    
    var isMandatory = true
    
    var isValid = true //FormValidable
    
    var uiProperties = FormItemUIProperties()
    
    // MARK: Init
    init(placeholder: String, value: String? = nil) {
        self.placeholder = placeholder
        self.value = value
    }
    
    // MARK: FormValidable
    func checkValidity() {
        if self.isMandatory {
            self.isValid = self.value != nil && self.value?.isEmpty == false
        } else {
            self.isValid = true
        }
    }
}
