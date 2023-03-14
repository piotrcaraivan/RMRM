//
//  UIMenuElement.State+Extensions.swift
//  Rick&Morty
//
//  Created by Петр Караиван on 12.03.2023.
//

import UIKit

extension UIMenuElement.State {
    func toggled() -> UIMenuElement.State {
        return self == .off ? .on : .off
    }
}
