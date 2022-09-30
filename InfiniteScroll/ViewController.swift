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
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    private var data: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        self.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        fetchNewData()
    }
    
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
                self?.data.append(contentsOf: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                break
            }
        })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].title
//        cell.setup(items[indexPath.item], atPosition: indexPath.row)
        return cell
    }
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, #line, "index:\(indexPath.row)", self.delegate, delegate)
        delegate?.goToProductDetail(didSelect: "items.recommendedList[indexPath.row]", atIndex: indexPath.row)
    }
}

extension ViewController: DetailsViewDelegate {
    func goToProductDetail(didSelect infiniteProduct: String, atIndex index: Int) {
        print(#function, #line, "index:\(index)", self.delegate, delegate)
    }
}
