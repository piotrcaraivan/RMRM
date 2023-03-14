//
//  UICollectionView+Extensions.swift
//  Rick&Morty
//
//  Created by Петр Караиван on 11.03.2023.
//

import UIKit

protocol Identifiable {
    static var reuseID: String { get }
}

extension UICollectionView {
    func dequeueCellOfType<Cell: UICollectionViewCell & Identifiable>(
        _ type: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: Cell.reuseID, for: indexPath) as! Cell
    }
}
