//
//  AppsHeaderCollectionCell.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 17.02.2023.
//

import UIKit

class AppsHeaderCollectionCell: UICollectionViewCell {
    static let reuseIdentifier = "AppsHeaderCollectionCell"
    let companyLabel = UILabel(font: .boldSystemFont(ofSize: 12))
    let titleLabel = UILabel(font: .systemFont(ofSize: 24))
    let imageView = UIImageView(cornerRadius: 8)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        autoLayoutStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        titleLabel.numberOfLines = 2
    }

    private func autoLayoutStackView() {
        let stackView = VerticalStackView(arrangedSubviews: [companyLabel, titleLabel, imageView], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }

    func configure(with model: SocialApp) {
        companyLabel.text = model.name
        titleLabel.text = model.tagline
        imageView.downloadedFrom(url: model.imageUrl)
    }
}
