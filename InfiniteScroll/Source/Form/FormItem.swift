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
    var valueInt: Int?
    var valueDouble: Double?
    var placeholder = ""
    var indexPath: IndexPath?
    var valueCompletion: ((String?) -> Void)?
    var valueCompletionInt: ((Int?) -> Void)?
    var valueCompletionDouble: ((Double?) -> Void)?

    var isMandatory = true
    
    var isValid = true //FormValidable
    
    var uiProperties = FormItemUIProperties()
    
    // MARK: Init
    init(label: String?, placeholder: String, value: String? = nil, valueInt: Int? = nil, valueDouble: Double? = nil) {
        self.label = label
        self.placeholder = placeholder
        self.value = value
        self.valueInt = valueInt
        self.valueDouble = valueDouble
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
