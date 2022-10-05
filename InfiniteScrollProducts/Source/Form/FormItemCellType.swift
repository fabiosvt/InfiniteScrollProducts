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
    case intField
    case doubleField
    case textView
    
    /// Registering methods for all forms items cell types
    ///
    /// - Parameter tableView: TableView where apply cells registration
    static func registerCells(for tableView: UITableView) {
        tableView.register(TextFieldCellType.self, forCellReuseIdentifier: "TextFieldCellType")
        tableView.register(TextViewCellType.self, forCellReuseIdentifier: "TextViewCellType")
    }
    
    func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
                
        switch self {
        case .textField, .intField, .doubleField:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCellType", for: indexPath) as? TextFieldCellType else { fatalError("Unable to dequeue subclassed cell") }
            return cell
        case .textView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCellType", for: indexPath) as? TextViewCellType else { fatalError("Unable to dequeue subclassed cell") }
            return cell
        }
        
    }
}
