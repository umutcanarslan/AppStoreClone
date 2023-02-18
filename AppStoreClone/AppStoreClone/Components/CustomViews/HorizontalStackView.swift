//
//  HorizontalStackView.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 18.02.2023.
//

import UIKit

class HorizontalStackView: UIStackView {

    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)

        arrangedSubviews.forEach({addArrangedSubview($0)})

        self.spacing = spacing
        self.axis = .horizontal
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
