//
//  NSDiffableDataSourceSnapshot+Extensions.swift
//  Rick&Morty
//
//  Created by Петр Караиван on 11.03.2023.
//

import UIKit

extension NSDiffableDataSourceSnapshot {
    init(sections: SectionIdentifierType...) {
        self.init()
        appendSections(sections)
    }
}
