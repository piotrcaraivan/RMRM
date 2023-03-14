//
//  RMTitleLabel.swift
//  Rick&Morty
//
//  Created by Петр Караиван on 11.03.2023.
//

import UIKit

final class RMTitleLabel: UILabel {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, textStyle: UIFont.TextStyle, text: String? = nil) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = .preferredFont(forTextStyle: textStyle)
        self.text = text
        configure()
    }
    
    private func configure() {
        textColor = .label
        lineBreakMode = .byTruncatingTail
        minimumScaleFactor = 0.9
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
