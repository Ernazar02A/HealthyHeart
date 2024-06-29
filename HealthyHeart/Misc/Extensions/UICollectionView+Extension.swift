//
//  UICollectionView+Extension.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

extension UICollectionView {
    func register<Cell: UICollectionViewCell>(_ type: Cell.Type) {
        register(type, forCellWithReuseIdentifier: type.identifier)
    }
    
    func getReuseCell<Cell: UICollectionViewCell>(for indexPath: IndexPath, with type: Cell.Type) -> Cell {
        dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as! Cell
    }
    
    func getCell<Cell>(for indexPath: IndexPath, with type: Cell.Type) -> Cell {
        cellForItem(at: indexPath) as! Cell
    }
    
    func register<View: UICollectionReusableView>(_ type: View.Type, kind: String) {
        register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: type.identifier)
    }
    
    func getReuseSupplementaryView<View: UICollectionReusableView>(
        for indexPath: IndexPath,
        kind: String,
        type: View.Type
    ) -> View {
        return dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: type.identifier,
            for: indexPath
        ) as! View
    }
    
    func getSupplementaryView<View>(for indexPath: IndexPath, with type: View.Type, kind: String) -> View {
        return supplementaryView(forElementKind: kind, at: indexPath) as! View
    }
    
    func registerCells(cells: [UICollectionViewCell.Type]) {
        cells.forEach { cell in
            self.register(cell.self, forCellWithReuseIdentifier: cell.identifier)
        }
    }
    
    func registerItemsSupplementaryView(view: UICollectionReusableView.Type) {
        self.register(view.self, forSupplementaryViewOfKind: view.identifier, withReuseIdentifier: view.identifier)
    }
}
