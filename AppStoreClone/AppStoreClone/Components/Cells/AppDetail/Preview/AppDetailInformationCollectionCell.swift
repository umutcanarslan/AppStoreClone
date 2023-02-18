//
//  AppDetailCollectionCell.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 18.02.2023.
//

import UIKit

class AppDetailInformationCollectionCell: UICollectionViewCell {

    static let reuseIdentifier = "AppDetailCollectionCell"

    let icon = UIImageView(cornerRadius: 16)
    let nameLabel = UILabel(font: .systemFont(ofSize: 24, weight: .medium), numberOfLines: 2)
    let descriptionLabel = UILabel(textColor: .gray, font: .systemFont(ofSize: 16, weight: .regular))
    let priceButton = UIButton(title: "$4.99")
    let whatsNewLabel = UILabel(font: .systemFont(ofSize: 20, weight: .bold))
    let versionLabel = UILabel(textColor: .gray, font: .systemFont(ofSize: 16, weight: .regular))
    let releaseNotesLabel = UILabel(font: .systemFont(ofSize: 16, weight: .regular), numberOfLines: 0)

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
        icon.constrainWidth(constant: 124)
        icon.constrainHeight(constant: 124)

        priceButton.backgroundColor = .link
        priceButton.setTitleColor(.white, for: .normal)
        priceButton.constrainWidth(constant: 82)
        priceButton.constrainHeight(constant: 32)
        priceButton.layer.cornerRadius = 16
    }

    private func autoLayoutFullStackView() {
        let stackView = VerticalStackView(
            arrangedSubviews: [autoLayoutHeaderStackView(), whatsNewLabel, versionLabel, releaseNotesLabel],
            spacing: 12
        )
        addSubview(stackView)

        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }

    private func autoLayoutHeaderStackView()  -> UIStackView {
        let stackView = HorizontalStackView(
            arrangedSubviews: [icon, autoLayoutHeaderLabelStackView()],
            spacing: 12
        )

        return stackView
    }

    private func autoLayoutHeaderLabelStackView()  -> UIStackView {
        let stackView = VerticalStackView(
            arrangedSubviews: [nameLabel, descriptionLabel, priceButton],
            spacing: 8
        )
        stackView.alignment = .leading

        return stackView
    }

    func configure(with model: SearchResult) {
        icon.downloadedFrom(url: model.artworkUrl100)
        nameLabel.text = model.trackName
        descriptionLabel.text = model.description
        priceButton.setTitle(model.formattedPrice, for: .normal)
        whatsNewLabel.text = "What's New"
        versionLabel.text = "1.09"
        releaseNotesLabel.text = model.releaseNotes
    }

}
