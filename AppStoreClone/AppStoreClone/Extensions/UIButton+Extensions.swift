//
//  UIButton+Extensions.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 17.02.2023.
//

import UIKit

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}
