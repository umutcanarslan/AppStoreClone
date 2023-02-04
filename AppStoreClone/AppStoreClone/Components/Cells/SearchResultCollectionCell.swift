//
//  SearchResultCollectionCell.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 4.02.2023.
//

import UIKit

class SearchResultCollectionCell: UICollectionViewCell {

    //MARK: - Properties
    static let reuseIdentifier = "SearchResultCollectionCell"

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Instagram"
        return label
    }()

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Videos"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.26M"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .heavy)
        button.backgroundColor = .init(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()

    lazy var screenShot1ImageView = self.createScreenShotImageView()
    lazy var screenShot2ImageView = self.createScreenShotImageView()
    lazy var screenShot3ImageView = self.createScreenShotImageView()

    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayoutFullStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - UI Helpers
    private func autoLayoutFullStackView() {
        let stackView = VerticalStackView(
            arrangedSubviews: [autoLayoutTopStackView(), autoLayoutImagesStackView()],
            spacing: 12
        )
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }

    private func autoLayoutTopStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [imageView, labelStackView(), getButton])
        stackView.spacing = 16
        stackView.alignment = .center

        return stackView
    }

    private func labelStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
        stackView.spacing = 2
        stackView.axis = .vertical

        return stackView
    }

    private func autoLayoutImagesStackView() -> UIStackView {
        let stackView = UIStackView(
            arrangedSubviews: [screenShot1ImageView, screenShot2ImageView, screenShot3ImageView]
        )
        stackView.spacing = 12
        stackView.distribution = .fillEqually

        return stackView
    }

    private func createScreenShotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }

    func configure(with model: SearchResult) {
        let rating = String(format: "%.2f", model.averageUserRating ?? 0.0)

        imageView.downloadedFrom(url: model.artworkUrl100)
        nameLabel.text = model.trackName
        categoryLabel.text = model.primaryGenreName
        ratingsLabel.text = "Ratings: \(rating)"
        screenShot1ImageView.downloadedFrom(url: model.screenshotUrls[0])
        screenShot2ImageView.downloadedFrom(url: model.screenshotUrls[1])
        screenShot3ImageView.downloadedFrom(url: model.screenshotUrls[2])
    }

}
