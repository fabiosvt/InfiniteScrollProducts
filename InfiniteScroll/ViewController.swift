//
//  ViewController.swift
//  infiniteScroll
//
//  Created by Fabio Silvestri on 29/09/22.
//

import UIKit

protocol DetailsViewDelegate: AnyObject {
    func goToProductDetail(didSelect infiniteProduct: String, atIndex index: Int)
}

class ViewController: UIViewController, UIScrollViewDelegate {
    weak var delegate: DetailsViewDelegate?
    private let apiCaller = APICaller()
    
    private var container: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Products"
        return label
    }()

    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    private var data: [[Item]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        self.delegate = self
        fetchNewData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.backgroundColor = UIColor.blue
        setupHierarchy()
        setupConstraints()
    }
}

// MARK: Viewcode

extension ViewController {

    func setupHierarchy() {
        view.addSubview(container)
        container.addSubview(headerLabel)
        container.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.leftAnchor.constraint(equalTo: view.leftAnchor),
            container.rightAnchor.constraint(equalTo: view.rightAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            tableView.topAnchor.constraint(equalTo: container.topAnchor, constant: 120.0),
            tableView.leftAnchor.constraint(equalTo: container.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: container.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -32.0)


        ])
    }
}

// MARK: Methods

extension ViewController {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        if scrollOffset + scrollViewHeight >= scrollContentSizeHeight {
            guard !apiCaller.isPaginating else { return }
            print("% '\(scrollOffset) \(scrollViewHeight)'")
            fetchNewData()
        }
    }
    
    private func fetchNewData() {
        apiCaller.fetchData(pagination: true, completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.data.append(contentsOf: [data])
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                break
            }
        })
    }
    
    @objc func visibleRow() {
        
    }
}

// MARK: TableView DataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        let button = UIButton(type: UIButton.ButtonType.system)
        
        label.text="Products section \(section)"
        button.setTitle("Test button", for: .normal)
        button.addTarget(self, action: #selector(visibleRow), for: .touchUpInside)
        
        view.addSubview(label)
        view.addSubview(button)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["label": label, "button": button, "view": view]
        
        let horizontallayoutContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[label]-60-[button]-10-|", options: .alignAllCenterY, metrics: nil, views: views)
        view.addConstraints(horizontallayoutContraints)
        
        let verticalLayoutContraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        view.addConstraint(verticalLayoutContraint)
        
        return view
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, #line, "index:\(indexPath.row)", self.delegate, delegate)
        delegate?.goToProductDetail(didSelect: "items.recommendedList[indexPath.row]", atIndex: indexPath.row)
    }
}

// MARK: Details delegate

extension ViewController: DetailsViewDelegate {
    func goToProductDetail(didSelect infiniteProduct: String, atIndex index: Int) {
        print(#function, #line, "index:\(index)", self.delegate, delegate)
    }
}
