//
//  Optional+Extensions.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 4.02.2023.
//

import Foundation

extension Optional where Wrapped == String {

    var isValid: Bool { !(self?.trimmingCharacters(in: .whitespaces)).isNilOrEmpty }
    var isNilOrEmpty: Bool {
        if let unwrapped = self {
            return unwrapped.isEmpty
        } else {
            return true
        }
    }

}
