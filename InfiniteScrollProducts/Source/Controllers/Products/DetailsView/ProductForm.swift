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
    var product: Product?
    var formDelegate: FormDelegate?

    init(product: Product) {
        self.formTitle = "Product"
        self.product = product
        self.configureForm()
    }

    // MARK: Form Validation
    @discardableResult
    func isValid() -> (Bool, String?) {
        
        var isValid = true
        for item in self.formItems {
            item.checkValidity()
            if !item.isValid {
                isValid = false
                return (isValid, item.label)
            }
        }
        return (isValid, nil)
    }
    
    private func configureForm() {
        guard var product = self.product else { return }
        
        let id = FormItem(label: "ID", placeholder: "Enter ID")
        id.uiProperties.cellType = FormItemCellType.intField
        id.value = product.id as AnyObject?
        id.uiProperties.keyboardType = .numberPad
        id.isMandatory = true
        id.valueCompletion = { [weak self, weak id] value in
            if let stringValue = value, let intValue = Int(stringValue) {
                product.id = intValue
                id?.value = value as AnyObject

            }
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let title = FormItem(label: "Title", placeholder: "Enter Title")
        title.uiProperties.cellType = FormItemCellType.textField
        title.value = product.title as AnyObject?
        title.uiProperties.keyboardType = .emailAddress
        title.isMandatory = true
        title.valueCompletion = { [weak self, weak title] value in
            product.title = value
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let description = FormItem(label: "Description", placeholder: "Enter Description")
        description.uiProperties.cellType = FormItemCellType.textField
        description.value = product.description as AnyObject?
        description.uiProperties.keyboardType = .namePhonePad
        description.isMandatory = true
        description.valueCompletion = { [weak self, weak description] value in
            product.description = value
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let price = FormItem(label: "Price", placeholder: "Enter Price")
        price.uiProperties.cellType = FormItemCellType.doubleField
        price.value = product.price as AnyObject?
        price.uiProperties.keyboardType = .namePhonePad
        price.isMandatory = true
        price.valueCompletion = { [weak self, weak price] value in
            if let stringValue = value, let doubleValue = Double(stringValue) {
                product.price = doubleValue
            }
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let discountPercentage = FormItem(label: "Discount Percentage", placeholder: "Enter Discount Percentage")
        discountPercentage.uiProperties.cellType = FormItemCellType.doubleField
        discountPercentage.value = product.discountPercentage as AnyObject?
        discountPercentage.uiProperties.keyboardType = .namePhonePad
        discountPercentage.valueCompletion = { [weak self, weak discountPercentage] value in
            if let stringValue = value, let doubleValue = Double(stringValue) {
                product.discountPercentage = doubleValue
            }
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let rating = FormItem(label: "Rating", placeholder: "Enter Rating")
        rating.uiProperties.cellType = FormItemCellType.doubleField
        rating.value = product.rating as AnyObject?
        rating.uiProperties.keyboardType = .namePhonePad
        rating.valueCompletion = { [weak self, weak rating] value in
            if let stringValue = value, let doubleValue = Double(stringValue) {
                product.rating = doubleValue
            }
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let stock = FormItem(label: "Stock", placeholder: "Enter Stock")
        stock.uiProperties.cellType = FormItemCellType.intField
        stock.value = product.stock as AnyObject?
        stock.uiProperties.keyboardType = .namePhonePad
        stock.valueCompletion = { [weak self, weak stock] value in
            if let stringValue = value, let intValue = Int(stringValue) {
                product.stock = intValue
            }
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let brand = FormItem(label: "Brand", placeholder: "Enter Brand")
        brand.uiProperties.cellType = FormItemCellType.textField
        brand.value = product.brand as AnyObject?
        brand.uiProperties.keyboardType = .namePhonePad
        brand.isMandatory = true
        brand.valueCompletion = { [weak self, weak brand] value in
            product.brand = value
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let category = FormItem(label: "Category", placeholder: "Enter Category")
        category.uiProperties.cellType = FormItemCellType.textField
        category.value = product.category as AnyObject?
        category.uiProperties.keyboardType = .namePhonePad
        category.isMandatory = true
        category.valueCompletion = { [weak self, weak category] value in
            product.category = value
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let thumbnail = FormItem(label: "Enter Thumbnail", placeholder: "Enter Thumbnail")
        thumbnail.uiProperties.cellType = FormItemCellType.textField
        thumbnail.value = product.thumbnail as AnyObject?
        thumbnail.uiProperties.keyboardType = .namePhonePad
        thumbnail.valueCompletion = { [weak self, weak thumbnail] value in
            product.thumbnail = value
            self?.formDelegate?.didUpdateForm(product: product)
        }
/*
        let images = FormItem(placeholder: "Enter Images")
        images.uiProperties.cellType = FormItemCellType.textField
        images.value = product.images
        images.uiProperties.keyboardType = .namePhonePad
        images.valueCompletion = { [weak self, weak images] value in
            self?.product?.images = value
            images?.value = value
        }
*/
        self.formItems = [id, title, description, price, discountPercentage, rating, stock, brand, category, thumbnail]
    }
}
