//
//  FirstViewController.swift
//  infiniteScroll
//
//  Created by Fabio Silvestri on 29/09/22.
//

import UIKit

protocol FirstViewControllerDelegate: AnyObject {
    func didTapProductDetailButton(product: Product)
    func didTapProductUpdateButton(product: Product)
}

class FirstViewController: UIViewController, UIScrollViewDelegate {
    private let service = APIService()
    private var isLoadingProducts = false
    private var maxProducsToFetch = 100
    private var columnNames = Array<Any>()
    
    weak var delegate: FirstViewControllerDelegate?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let w = view.frame.width
        layout.estimatedItemSize = CGSize(width: w, height: 150)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.register(ViewControllerCell.self, forCellWithReuseIdentifier: CollectionViewCellTypes.viewControllerCell.description)
        view.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewCellTypes.viewControllerHeaderCell.description)
        return view
    }()
    
    private var data: [[Product]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.contentInsetAdjustmentBehavior = .never
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.view.backgroundColor = UIColor.clear
        let safeAreaBottom: CGFloat = 12.0
        collectionView.contentInset = UIEdgeInsets(top: safeAreaBottom, left: 0, bottom: 0, right: 0.0)
        do {
            columnNames = try Product.instance.allProperties()
        } catch _ {
            debugPrint(#function, #line, "error")
        }
        fetchNewProducts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViewCode()
    }
}

extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        debugPrint(#function, #line, data.count)
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        debugPrint(#function, #line, data, section, data[section].count)
        return data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellTypes.viewControllerCell.description, for: indexPath) as? ViewControllerCell else {
            fatalError("Unable to dequeue subclassed cell")
        }
        let item = data[indexPath.section][indexPath.row]
        cell.product = item
        cell.columnNames = columnNames
        cell.delegate = self
        cell.setupViewCode()
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30.0)
    }
}

// MARK: Methods

extension FirstViewController {
    
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
                self.data.append(contentsOf: [products.shuffled()])
                DispatchQueue.main.async {
                    self.isLoadingProducts = false
                    self.collectionView.reloadData()
                }
            }
        }
        
    }
}

// MARK: Details delegate

extension FirstViewController: FirstViewControllerDelegate {
    func didTapProductDetailButton(product: Product) {
        debugPrint(#function, #line, product)
        let push = DetailsView(product: product)
        push.delegate = self
        self.navigationController?.pushViewController(push, animated: true)
    }

    func didTapProductUpdateButton(product: Product) {
        debugPrint(#function, #line, product)
    }
}

// MARK: ViewCode

extension FirstViewController: ViewCode {
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
