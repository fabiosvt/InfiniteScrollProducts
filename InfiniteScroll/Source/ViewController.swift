//
//  ViewController.swift
//  infiniteScroll
//
//  Created by Fabio Silvestri on 29/09/22.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    private let apiCaller = APICaller()
    
    private var container: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Products"
        label.font = UIFont(name: "Halvetica", size: 17)
        label.textColor = .white
        return label
    }()

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

        fetchNewData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupHierarchy()
        setupConstraints()
        setupConfiguration()
    }
}

extension ViewController: ViewCode {
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

            headerLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 80.0),
            headerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),

            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20.0),
            tableView.leftAnchor.constraint(equalTo: container.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: container.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -32.0)

        ])
    }

    func setupConfiguration() {
        self.view.backgroundColor = UIColor.blue
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
        view.setup()
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
        cell.setup()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let push = DetailsView(product: data[indexPath.section][indexPath.row])
         //self.present(push, animated: true, completion: nil)
        print(self.navigationController)
         self.navigationController?.pushViewController(push, animated: true)

    }
}

// MARK: Details delegate

extension ViewController: DetailsViewDelegate {
    func goToProductDetail(didSelect infiniteProduct: Product) {
        print(#function, #line, infiniteProduct)
    }
}

