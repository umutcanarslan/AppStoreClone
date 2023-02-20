//
//  AppsHeaderCollectionReusableView.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 17.02.2023.
//

import UIKit

class AppsHeaderCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifer = "AppsHeaderCollectionReusableView"
    let appsHeaderhorizontalController = AppsHeaderHorizontalViewController()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(appsHeaderhorizontalController.view)
        appsHeaderhorizontalController.view.fillSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: [SocialApp]) {
        appsHeaderhorizontalController.configure(with: model)
    }
}
