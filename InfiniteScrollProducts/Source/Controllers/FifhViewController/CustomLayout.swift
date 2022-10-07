//
//  CustomLayout.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 11/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import UIKit

class CustomLayout: UICollectionViewLayout {
    private var computedContentSize: CGSize = .zero
    private var cellAttributes = [IndexPath: UICollectionViewLayoutAttributes]()

    let itemWidth = 100
    let itemHeight = 60

    let gridLineWidth = 1
    
    override func prepare() {
        
        guard let collectionView = collectionView else {
            fatalError("not a collection view?")
        }

        let numberOfSections = collectionView.numberOfSections
        if numberOfSections == 0 {
            return
        }
        
        // Clear out previous results
        computedContentSize = .zero
        cellAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
        
        let numItems = collectionView.numberOfItems(inSection: 0)
        let numSections = collectionView.numberOfSections

        let widthPlusGridLineWidth = itemWidth + gridLineWidth
        let heightPlusGridLineWidth = itemHeight + gridLineWidth
        
        for section in 0 ..< numSections {
            for item in 0 ..< numItems {
                let itemFrame = CGRect(x: item * widthPlusGridLineWidth + gridLineWidth,
                                       y: section * heightPlusGridLineWidth + gridLineWidth,
                                       width: itemWidth, height: itemHeight)
                
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = itemFrame
                
                cellAttributes[indexPath] = attributes
            }
        }
        
        computedContentSize = CGSize(width: numItems * widthPlusGridLineWidth + gridLineWidth, height: numSections * heightPlusGridLineWidth + gridLineWidth) // Store computed content size
    }
    
    override var collectionViewContentSize: CGSize {
        return computedContentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributeList = [UICollectionViewLayoutAttributes]()
        
        for (_, attributes) in cellAttributes {
            if attributes.frame.intersects(rect) {
                attributeList.append(attributes)
            }
        }
        
        return attributeList
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttributes[indexPath]
    }
    
}
