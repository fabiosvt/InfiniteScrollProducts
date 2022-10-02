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
    
    init(product: Product) {
        self.formTitle = "Product"
        self.product = product
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
        guard let product = self.product else { return }
        
        let id = FormItem(label: "ID", placeholder: "Enter ID")
        id.uiProperties.cellType = FormItemCellType.intField
        id.valueInt = product.id
        id.valueCompletionInt = { [weak self, weak id] value in
            self?.product?.id = value
            id?.valueInt = value
        }

        let title = FormItem(label: "Title", placeholder: "Enter Title")
        title.uiProperties.cellType = FormItemCellType.textField
        title.value = product.title
        title.uiProperties.keyboardType = .emailAddress
        title.valueCompletion = { [weak self, weak title] value in
            self?.product?.title = value
            title?.value = value
        }

        let description = FormItem(label: "Description", placeholder: "Enter Description")
        description.uiProperties.cellType = FormItemCellType.textField
        description.value = product.description
        description.uiProperties.keyboardType = .namePhonePad
        description.valueCompletion = { [weak self, weak description] value in
            self?.product?.description = value
            description?.value = value
        }

        let price = FormItem(label: "Price", placeholder: "Enter Price")
        price.uiProperties.cellType = FormItemCellType.doubleField
        price.valueDouble = product.price
        price.uiProperties.keyboardType = .namePhonePad
        price.valueCompletionDouble = { [weak self, weak price] value in
            self?.product?.price = value
            price?.valueDouble = value
        }

        let discountPercentage = FormItem(label: "Discount Percentage", placeholder: "Enter Discount Percentage")
        discountPercentage.uiProperties.cellType = FormItemCellType.doubleField
        discountPercentage.valueDouble = product.discountPercentage
        discountPercentage.uiProperties.keyboardType = .namePhonePad
        discountPercentage.valueCompletionDouble = { [weak self, weak discountPercentage] value in
            self?.product?.discountPercentage = value
            discountPercentage?.valueDouble = value
        }

        let rating = FormItem(label: "Rating", placeholder: "Enter Rating")
        rating.uiProperties.cellType = FormItemCellType.doubleField
        rating.valueDouble = product.rating
        rating.uiProperties.keyboardType = .namePhonePad
        rating.valueCompletionDouble = { [weak self, weak discountPercentage] value in
            self?.product?.rating = value
            rating.valueDouble = value
        }

        let stock = FormItem(label: "Stock", placeholder: "Enter Stock")
        stock.uiProperties.cellType = FormItemCellType.intField
        stock.valueInt = product.stock
        stock.uiProperties.keyboardType = .namePhonePad
        stock.valueCompletionInt = { [weak self, weak stock] value in
            self?.product?.stock = value
            stock?.valueInt = value
        }

        let brand = FormItem(label: "Brand", placeholder: "Enter Brand")
        brand.uiProperties.cellType = FormItemCellType.textField
        brand.value = product.brand
        brand.uiProperties.keyboardType = .namePhonePad
        brand.valueCompletion = { [weak self, weak brand] value in
            self?.product?.brand = value
            brand?.value = value
        }

        let category = FormItem(label: "Category", placeholder: "Enter Category")
        category.uiProperties.cellType = FormItemCellType.textField
        category.value = product.category
        category.uiProperties.keyboardType = .namePhonePad
        category.valueCompletion = { [weak self, weak category] value in
            self?.product?.category = value
            category?.value = value
        }

        let thumbnail = FormItem(label: "Enter Thumbnail", placeholder: "Enter Thumbnail")
        thumbnail.uiProperties.cellType = FormItemCellType.textField
        thumbnail.value = product.thumbnail
        thumbnail.uiProperties.keyboardType = .namePhonePad
        thumbnail.valueCompletion = { [weak self, weak thumbnail] value in
            self?.product?.thumbnail = value
            thumbnail?.value = value
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
