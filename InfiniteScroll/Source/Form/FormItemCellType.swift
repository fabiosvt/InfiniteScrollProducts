//
//  FormItemCellType.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 02/10/22.
//

import Foundation
import UIKit

/// Conform receiver to have data validation behavior
protocol FormValidable {
    var isValid: Bool {get set}
    var isMandatory: Bool {get set}
    func checkValidity()
}

/// Conform the view receiver to be updated with a form item
protocol FormUpdatable {
    func update(with formItem: FormItem)
}

/// Conform receiver to have a form item property
protocol FormConformity {
    var formItem: FormItem? {get set}
}

/// UI Cell Type to be displayed
enum FormItemCellType {
    case textField
    case textView
    
    /// Registering methods for all forms items cell types
    ///
    /// - Parameter tableView: TableView where apply cells registration
    static func registerCells(for tableView: UITableView) {
        tableView.register(FormTextFieldTableViewCell.self, forCellReuseIdentifier: "FormTextFieldTableViewCell")
        tableView.register(FormTextViewTableViewCell.self, forCellReuseIdentifier: "FormTextViewTableViewCell")
    }
    
    /// Correctly dequeue the UITableViewCell according to the current cell type
    ///
    /// - Parameters:
    ///   - tableView: TableView where cells previously registered
    ///   - indexPath: indexPath where dequeue
    /// - Returns: a non-nullable UITableViewCell dequeued
    func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
                
        switch self {
        case .textField:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FormTextFieldTableViewCell", for: indexPath) as? FormTextFieldTableViewCell else { return UITableViewCell() }
            cell.setup()
            return cell
        case .textView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FormTextViewTableViewCell", for: indexPath) as? FormTextViewTableViewCell else { return UITableViewCell() }
            return cell
        }
        
    }
}
