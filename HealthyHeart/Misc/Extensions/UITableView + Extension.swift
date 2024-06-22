//
//  UITableView + Extension.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

extension UITableView {
    
    func register(cell: UITableViewCell.Type) {
        self.register(cell.self, forCellReuseIdentifier: cell.identifier)
    }
    
    func getCell<Cell: UITableViewCell>(for indexPath: IndexPath, with type: Cell.Type) -> Cell {
        dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! Cell
    }
}
