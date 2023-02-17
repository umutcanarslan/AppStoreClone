//
//  UILabel+Extensions.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 4.02.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
    }
}
