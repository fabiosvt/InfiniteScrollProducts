//
//  ViewController.swift
//  infiniteScroll
//
//  Created by Fabio Silvestri on 29/09/22.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    private let apiCaller = APICaller()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DetailsCell.self, forCellReuseIdentifier: "DetailsCell")
        return tableView
    }()

    private var data: [[Product]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.sectionHeaderTopPadding = 0.0
        tableView.contentInsetAdjustmentBehavior = .never
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.view.backgroundColor = UIColor.clear
        var safeAreaBottom: CGFloat = 12.0
        tableView.contentInset = UIEdgeInsets(top: safeAreaBottom, left: 0, bottom: 0, right: 0.0)
        fetchNewData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViewCode()
    }
}

extension ViewController: ViewCode {
    func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0)
        ])
    }

    func setupConfiguration() {
        self.view.backgroundColor = UIColor.blue
        self.navigationItem.title = "Products"
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
            debugPrint("% '\(scrollOffset) \(scrollViewHeight)'")
            fetchNewData()
        }
    }
    
    private func fetchNewData() {
        apiCaller.fetchData(pagination: true, completion: { [weak self] result in
            switch result {
            case .success(var data):
                data.shuffle()
                self?.data.append(contentsOf: [data])
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                break
            }
        })
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
        let view = HeaderCell(section: section)
        view.setupViewCode()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as? DetailsCell else { return UITableViewCell() }
        cell.model = CellModel(item: data[indexPath.section][indexPath.row], indexPath: indexPath)
        cell.delegate = self
        cell.setupViewCode()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let push = DetailsView(product: data[indexPath.section][indexPath.row])
        self.navigationController?.pushViewController(push, animated: true)
    }
}

// MARK: Details delegate

extension ViewController: DetailsViewDelegate {
    func goToProductDetail(didSelect infiniteProduct: Product) {
        debugPrint(#function, #line, infiniteProduct)
    }
}

