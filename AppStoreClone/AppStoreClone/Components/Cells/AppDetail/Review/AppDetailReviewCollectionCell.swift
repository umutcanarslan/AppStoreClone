//
//  AppDetailReviewCollectionCell.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 19.02.2023.
//

import UIKit

class AppDetailReviewCollectionCell: UICollectionViewCell {

    static let reuseIdentifier = "AppDetailReviewCollectionCell"
    let appDetailReviewController = AppDetailReviewController()

    let reviewLabel = UILabel(font: .systemFont(ofSize: 20, weight: .bold))

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        autoLayoutFullStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - UI Helpers
    private func setupUI() {
        reviewLabel.text = "Review & Ratings"
    }

    private func autoLayoutFullStackView() {
        addSubview(reviewLabel)
        addSubview(appDetailReviewController.view)

        reviewLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(
                top: 8,
                left: 16,
                bottom: 0,
                right: 16
            )
        )

        appDetailReviewController.view.anchor(
            top: reviewLabel.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(
                top: 16,
                left: 0,
                bottom: 0,
                right: 0
            )
        )
    }

    func configure(with model: [Entry]) {
        appDetailReviewController.configure(with: model)
    }

}
