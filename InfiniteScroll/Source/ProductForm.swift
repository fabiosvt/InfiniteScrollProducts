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
        id.intValue = product.id
        id.uiProperties.keyboardType = .numberPad
        id.isMandatory = true
        id.valueCompletionInt = { [weak self, weak id] value in
            product.id = value
            id?.intValue = value
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let title = FormItem(label: "Title", placeholder: "Enter Title")
        title.uiProperties.cellType = FormItemCellType.textField
        title.value = product.title
        title.uiProperties.keyboardType = .emailAddress
        title.isMandatory = true
        title.valueCompletion = { [weak self, weak title] value in
            self?.product?.title = value
            title?.value = value
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let description = FormItem(label: "Description", placeholder: "Enter Description")
        description.uiProperties.cellType = FormItemCellType.textField
        description.value = product.description
        description.uiProperties.keyboardType = .namePhonePad
        description.isMandatory = true
        description.valueCompletion = { [weak self, weak description] value in
            self?.product?.description = value
            description?.value = value
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let price = FormItem(label: "Price", placeholder: "Enter Price")
        price.uiProperties.cellType = FormItemCellType.doubleField
        price.doubleValue = product.price
        price.uiProperties.keyboardType = .namePhonePad
        price.isMandatory = true
        price.valueCompletionDouble = { [weak self, weak price] value in
            self?.product?.price = value
            price?.doubleValue = value
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let discountPercentage = FormItem(label: "Discount Percentage", placeholder: "Enter Discount Percentage")
        discountPercentage.uiProperties.cellType = FormItemCellType.doubleField
        discountPercentage.doubleValue = product.discountPercentage
        discountPercentage.uiProperties.keyboardType = .namePhonePad
        discountPercentage.valueCompletionDouble = { [weak self, weak discountPercentage] value in
            self?.product?.discountPercentage = value
            discountPercentage?.doubleValue = value
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let rating = FormItem(label: "Rating", placeholder: "Enter Rating")
        rating.uiProperties.cellType = FormItemCellType.doubleField
        rating.doubleValue = product.rating
        rating.uiProperties.keyboardType = .namePhonePad
        rating.valueCompletionDouble = { [weak self, weak rating] value in
            self?.product?.rating = value
            rating?.doubleValue = value
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let stock = FormItem(label: "Stock", placeholder: "Enter Stock")
        stock.uiProperties.cellType = FormItemCellType.intField
        stock.intValue = product.stock
        stock.uiProperties.keyboardType = .namePhonePad
        stock.valueCompletionInt = { [weak self, weak stock] value in
            self?.product?.stock = value
            stock?.intValue = value
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let brand = FormItem(label: "Brand", placeholder: "Enter Brand")
        brand.uiProperties.cellType = FormItemCellType.textField
        brand.value = product.brand
        brand.uiProperties.keyboardType = .namePhonePad
        brand.isMandatory = true
        brand.valueCompletion = { [weak self, weak brand] value in
            self?.product?.brand = value
            brand?.value = value
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let category = FormItem(label: "Category", placeholder: "Enter Category")
        category.uiProperties.cellType = FormItemCellType.textField
        category.value = product.category
        category.uiProperties.keyboardType = .namePhonePad
        category.isMandatory = true
        category.valueCompletion = { [weak self, weak category] value in
            self?.product?.category = value
            category?.value = value
            self?.formDelegate?.didUpdateForm(product: product)
        }

        let thumbnail = FormItem(label: "Enter Thumbnail", placeholder: "Enter Thumbnail")
        thumbnail.uiProperties.cellType = FormItemCellType.textField
        thumbnail.value = product.thumbnail
        thumbnail.uiProperties.keyboardType = .namePhonePad
        thumbnail.valueCompletion = { [weak self, weak thumbnail] value in
            self?.product?.thumbnail = value
            thumbnail?.value = value
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
