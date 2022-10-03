//
//  DetailsView.swift
//  infiniteScroll
//
//  Created by Fabio Silvestri on 29/09/22.
//

import UIKit

protocol FormDelegate {
    func didUpdateForm(product: Product)
}

class DetailsView: UIViewController, UITableViewDelegate {

    var product: Product
    
    fileprivate var form: ProductForm

    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TextFieldCellType.self, forCellReuseIdentifier: "TextFieldCellType")
        tableView.register(TextViewCellType.self, forCellReuseIdentifier: "TextViewCellType")
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    private var container: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Halvetica", size: 17)
        label.textColor = .red
        return label
    }()

    private let button: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Update", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(updateTable), for: .touchUpInside)
        return button
    }()
    
    init(product: Product) {
        self.product = product
        self.form = ProductForm(product: product)
        super.init(nibName: nil, bundle: nil)
        self.form.formDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViewCode()
    }

    @objc func updateTable() {
        label.text = "Invalid field "
       let isValid = form.isValid()
        if !isValid.0, let fieldError = isValid.1 {
            label.text = "Invalid field \(fieldError)"
        } else {
            debugPrint(product)
          //  self.navigationController?.popViewController(animated: true) //deinits correctly
        }
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

extension DetailsView: FormDelegate {

    func didUpdateForm(product: Product) {
        debugPrint(product)
        self.product = product
    }

}

extension DetailsView: ViewCode {
    func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(container)
        container.addSubview(label)
        container.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: container.topAnchor),
            
            container.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            container.leftAnchor.constraint(equalTo: view.leftAnchor),
            container.heightAnchor.constraint(equalToConstant: 80),
            container.rightAnchor.constraint(equalTo: view.rightAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            label.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 12),
            label.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.7),
            label.bottomAnchor.constraint(equalTo: button.topAnchor),

            button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -24),
        ])
    }
    
    func setupConfiguration() {
        tableView.backgroundColor = UIColor.blue
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        container.backgroundColor = UIColor.blue
        self.navigationItem.title = self.form.formTitle
    }
}
