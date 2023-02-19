//
//  ScreenshotCell.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 19.02.2023.
//

import UIKit

class ScreenshotCollectionCell: UICollectionViewCell {

    static let reuseIdentifier = "ScreenshotCell"

    let appScreenshot = UIImageView(cornerRadius: 12)

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(appScreenshot)
        appScreenshot.fillSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with url: URL) {
        appScreenshot.downloadedFrom(url: url)
    }

}
