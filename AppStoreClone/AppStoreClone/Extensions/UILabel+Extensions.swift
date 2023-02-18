//
//  UILabel+Extensions.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 4.02.2023.
//

import UIKit

extension UILabel {
    convenience init(textColor: UIColor = .black, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
    }
}
