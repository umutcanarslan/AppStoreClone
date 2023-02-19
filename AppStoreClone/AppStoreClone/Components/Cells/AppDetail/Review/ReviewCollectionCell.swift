//
//  ReviewCollectionCell.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 19.02.2023.
//

import UIKit

class ReviewCollectionCell: UICollectionViewCell {

    static let reuseIdentifier = "ReviewCollectionCell"

    let titleLabel = UILabel(font: .systemFont(ofSize: 16, weight: .bold))
    let authorLabel = UILabel(font: .systemFont(ofSize: 16, weight: .regular))
    let bodyLabel = UILabel(font: .systemFont(ofSize: 16, weight: .regular), numberOfLines: 5)
    let starStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach { (_) in
            let starImageView = UIImageView(image: UIImage(imageLiteralResourceName: "star"))
            starImageView.constrainWidth(constant: 24)
            starImageView.constrainHeight(constant: 24)
            arrangedSubviews.append(starImageView)
        }

        arrangedSubviews.append(UIView())
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        layer.cornerRadius = 16
        clipsToBounds = true

        setupUI()
        autoLayoutFullStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - UI Helpers
    private func setupUI() {
        authorLabel.textColor = .systemGray
    }

    private func autoLayoutFullStackView() {
        let stackView = VerticalStackView(
            arrangedSubviews: [autoLayoutBodyAndAuthorStackView(), starStackView, bodyLabel],
            spacing: 16
        )

        addSubview(stackView)
        stackView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(
                top: 16,
                left: 16,
                bottom: 16,
                right: 16
            )
        )
    }

    private func autoLayoutBodyAndAuthorStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, UIView(), authorLabel])
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)

        return stackView
    }

    func configure(with model: Entry) {
        titleLabel.text = model.title.label
        bodyLabel.text = model.content.label
        authorLabel.text = model.author.name.label

        for (index, view) in starStackView.arrangedSubviews.enumerated() {
            if let rating = Int(model.rating.label) {
                view.alpha = index >= rating ? 0.3 : 1
            }
        }
    }

}
