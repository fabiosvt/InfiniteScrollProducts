//
//  FifthViewController.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 10/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController {
    private let service = APIService()
    private var isLoadingProducts = false
    private var maxProducsToFetch = 100
    private var columnNames = Array<Any>()

    private lazy var collectionView: UICollectionView = {
        let layout = CustomLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.contentInsetAdjustmentBehavior = .always
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .black
        view.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCellTypes.contentCellIdentifier.description)
        view.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewCellTypes.viewControllerHeaderCell.description)
        return view
    }()
    
    private var theData = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.contentInsetAdjustmentBehavior = .never

        view.backgroundColor = .systemYellow
        do {
            columnNames = try Product.instance.allProperties()
            theData.append(contentsOf: [Product()])
        } catch _ {
            debugPrint(#function, #line, "error")
        }
        fetchNewProducts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViewCode()
    }
        
}

// MARK: UICollectionViewDataSource

extension FifthViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        debugPrint(#function, #line, theData.count)
        return theData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columnNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCellTypes.contentCellIdentifier.description), for: indexPath) as? CustomCollectionViewCell else {
            fatalError("Unable to dequeue subclassed cell")
        }
        if indexPath.section == 0 {
            if let column = columnNames[indexPath.row] as? (String, Any) {
                cell.myLabel.text = "\(column.0)"
            }
        } else {
            let product = theData[indexPath.section]
            if let column = columnNames[indexPath.row] as? (String, Any), let fieldValue = product.value(for: column.0) {
                cell.myLabel.text = "\(fieldValue)"
            }
        }

        // set background color for top row, else use white
        cell.contentView.backgroundColor = indexPath.section == 0 ? .yellow : .white

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind elementKind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if (elementKind == UICollectionView.elementKindSectionHeader) {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: CollectionViewCellTypes.viewControllerHeaderCell.description, for: indexPath) as? HeaderCell else {
                fatalError("Unable to dequeue subclassed cell")
            }
            headerView.section = indexPath.section
            headerView.setupConfiguration()
            return headerView
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}

 extension UIView {
     
     func setCardView(view : UIView){
         
         view.layer.cornerRadius = 2.0
         view.layer.borderColor  =  UIColor.lightGray.cgColor
         view.layer.borderWidth = 2.0
         view.layer.shadowOpacity = 1.0
         view.layer.shadowColor =  UIColor.clear.cgColor
         view.layer.shadowRadius = 2.0
         view.layer.shadowOffset = CGSize(width:3, height: 3)
         view.layer.masksToBounds = true
         
     }
 }

// MARK: ViewCode

extension FifthViewController: ViewCode {
    func setupHierarchy() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0)
        ])
    }
    
    func setupConfiguration() {
        self.view.backgroundColor = UIColor.blue
        self.navigationItem.title = "Products"
    }
    
}

extension FifthViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !self.isLoadingProducts else { return }
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        if scrollOffset > scrollContentSizeHeight - scrollViewHeight {
            debugPrint(#function, #line, "\(scrollOffset) \(scrollContentSizeHeight) \(scrollViewHeight)")
            fetchNewProducts()
        }
    }
    
    private func fetchNewProducts() {
        debugPrint(#function, #line, "### REQUEST")
        let request = APIRequest.fetchProductsApi(limit: maxProducsToFetch)
        isLoadingProducts = true
        service.fetchProducts(request: request) { (result, errors, response) in
            if let errors = errors, errors.count > 0 {
                debugPrint("error")
            } else if let data = response as? Products {
                let products = data.products
                debugPrint(#function, #line, "### New products downloaded: ", products.count)
                self.theData.append(contentsOf: products.shuffled())
                print("total elements in array ", self.theData.count)
                DispatchQueue.main.async {
                    self.isLoadingProducts = false
                    self.collectionView.reloadData()
                }
            }
        }
    }
}
