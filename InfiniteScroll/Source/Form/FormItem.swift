//
//  FormItem.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 02/10/22.
//

import UIKit

/// ViewModel to display and react to text events, to update data
class FormItem: FormValidable {
    var label: String?
    var value: AnyObject?
    var placeholder = ""
    var indexPath: IndexPath?
    var valueCompletion: ((String?) -> Void)?
    var isMandatory = false
    var isValid: Bool
    
    var uiProperties = FormItemUIProperties()
    
    // MARK: Init
    init(label: String?, placeholder: String, value: AnyObject? = nil) {
        self.label = label
        self.placeholder = placeholder
        self.value = value
        self.isValid = true
    }
    
    private func checkDataForValue() -> String? {
        switch self.value {
        case .none, .some(is NSNull):       return nil
        case .some(let value as String):    return value == "<null>" ? nil : value
        case .some(let value):              return "\(value)"
        }
    }
    
    // MARK: FormValidable
    func checkValidity() {
        if self.isMandatory {
            let anyValue = self.checkDataForValue()
            self.isValid = anyValue != nil && anyValue != nil && anyValue?.isEmpty == false
         } else {
            self.isValid = true
        }
        debugPrint(self.value, self.value?.isEmpty, self.isValid)
    }
}
