//
//  CollectionViewController.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 04/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UIViewController {
    var data = [UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green]
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(ColorsCollectionViewCell.self, forCellWithReuseIdentifier: "colorscell")
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .white
    }
    
    override func loadView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        self.view = collectionView
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
    
}
extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorscell", for: indexPath) as? ColorsCollectionViewCell else { fatalError("Unable to dequeue subclassed cell") }
        let data = self.data[indexPath.item]
        cell.setupCell(colour: data)
        return cell
    }
}
