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
    var value: String?
    var intValue: Int?
    var doubleValue: Double?
    var placeholder = ""
    var indexPath: IndexPath?
    var valueCompletion: ((String?) -> Void)?
    var valueCompletionInt: ((Int?) -> Void)?
    var valueCompletionDouble: ((Double?) -> Void)?
    var isMandatory = false
    var isValid: Bool
    
    var uiProperties = FormItemUIProperties()
    
    // MARK: Init
    init(label: String?, placeholder: String, value: String? = nil, intValue: Int? = nil, doubleValue: Double? = nil) {
        self.label = label
        self.placeholder = placeholder
        self.value = value
        self.intValue = intValue
        self.doubleValue = doubleValue
        self.isValid = true
    }
    
    // MARK: FormValidable
    func checkValidity() {
        if self.isMandatory {
            switch self.uiProperties.cellType {
            case .textField:
                self.isValid = self.value != nil && self.value?.isEmpty == false
            case .intField:
                self.isValid = self.intValue != nil
            case .doubleField:
                self.isValid = self.doubleValue != nil
            default:
                self.isValid = self.value != nil && self.value?.isEmpty == false
            }
        } else {
            self.isValid = true
        }
    }
}
