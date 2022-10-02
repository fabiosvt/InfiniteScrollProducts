//
//  DetailsView.swift
//  infiniteScroll
//
//  Created by Fabio Silvestri on 29/09/22.
//

import UIKit

class DetailsView: UIViewController, UITableViewDelegate {

    let product: Product
    
    fileprivate var form: ProductForm

    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TextFieldCellType.self, forCellReuseIdentifier: "TextFieldCellType")
        tableView.register(IntFieldCellType.self, forCellReuseIdentifier: "IntFieldCellType")
        tableView.register(DoubleFieldCellType.self, forCellReuseIdentifier: "DoubleFieldCellType")
        tableView.register(TextViewCellType.self, forCellReuseIdentifier: "TextViewCellType")
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    init(product: Product) {
        self.product = product
        self.form = ProductForm(product: product)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupHierarchy()
        setupConstraints()
        setupConfiguration()
    }

}

// MARK: - UITableViewDataSource
extension DetailsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.form.formItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.form.formItems[indexPath.row]
        let cell: UITableViewCell
        if let cellType = self.form.formItems[indexPath.row].uiProperties.cellType {
            cell = cellType.dequeueCell(for: tableView, at: indexPath)
        } else {
            cell = UITableViewCell() //or anything you want
        }
        
        if let formUpdatableCell = cell as? FormUpdatable {
            item.indexPath = indexPath
            formUpdatableCell.update(with: item)
        }
        
        return cell
    }
}

extension DetailsView: ViewCode {
    func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupConfiguration() {
        tableView.backgroundColor = UIColor.blue
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        self.navigationItem.title = self.form.formTitle
    }
}
