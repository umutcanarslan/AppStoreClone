//
//  AppDetailPreviewCollectionCell.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 19.02.2023.
//

import UIKit

class AppDetailPreviewCollectionCell: UICollectionViewCell {

    static let reuseIdentifier = "AppDetailPreviewCollectionCell"
    let appDetailPreviewController = AppDetailPreviewController()

    let previewLabel = UILabel(font: .systemFont(ofSize: 20, weight: .bold))

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
        previewLabel.text = "Preview"
    }

    private func autoLayoutFullStackView() {
        addSubview(previewLabel)
        addSubview(appDetailPreviewController.view)

        previewLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(
                top: 0,
                left: 16,
                bottom: 0,
                right: 16
            )
        )

        appDetailPreviewController.view.anchor(
            top: previewLabel.bottomAnchor,
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

    func configure(with urls: [URL]) {
        appDetailPreviewController.configure(with: urls)
    }

}
