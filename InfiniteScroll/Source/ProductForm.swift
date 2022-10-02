//
//  ProductForm.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 02/10/22.
//

import Foundation

class ProductForm {
    var formItems = [FormItem]()
    
    var formTitle: String?
    var item: Product?
    var id: Int?
    var title: String?
    var description: String?
    
    init() {
        self.formTitle = "Product"
        self.configureProduct()
    }
    
    // MARK: Form Validation
    @discardableResult
    func isValid() -> (Bool, String?) {
        
        var isValid = true
        for item in self.formItems {
            item.checkValidity()
            if !item.isValid {
                isValid = false
            }
        }
        return (isValid, nil)
    }
    
    private func configureProduct() {
        let idItem = FormItem(placeholder: "Enter ID")
        idItem.uiProperties.cellType = FormItemCellType.textField
        idItem.value = "\(String(describing: self.id))"
        idItem.valueCompletion = { [weak self, weak idItem] value in
            self?.id = Int(value ?? "")
            idItem?.value = value
        }

        let titleItem = FormItem(placeholder: "Enter Title")
        titleItem.uiProperties.cellType = FormItemCellType.textField
        titleItem.value = self.title
        titleItem.uiProperties.keyboardType = .emailAddress
        titleItem.valueCompletion = { [weak self, weak titleItem] value in
            self?.title = value
            titleItem?.value = value
        }

        let descriptionItem = FormItem(placeholder: "Enter Description")
        descriptionItem.uiProperties.cellType = FormItemCellType.textField
        descriptionItem.value = self.description
        descriptionItem.uiProperties.keyboardType = .namePhonePad
        descriptionItem.valueCompletion = { [weak self, weak descriptionItem] value in
            self?.description = value
            descriptionItem?.value = value
        }

        self.formItems = [idItem, titleItem, descriptionItem]
    }
}
