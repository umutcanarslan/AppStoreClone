//
//  AppDetailPreviewController.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 19.02.2023.
//

import UIKit

class AppDetailPreviewController: HorizontalSnappingController {

    var screenshotURLs: [URL] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(
            ScreenshotCollectionCell.self,
            forCellWithReuseIdentifier: ScreenshotCollectionCell.reuseIdentifier
        )

        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    func configure(with urls: [URL]) {
        self.screenshotURLs = urls
    }

}

//MARK: - CollectionView Data Source
extension AppDetailPreviewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshotURLs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ScreenshotCollectionCell.reuseIdentifier,
            for: indexPath
        ) as? ScreenshotCollectionCell else { return .init() }

        cell.configure(with: screenshotURLs[indexPath.item])
        return cell
    }
}

//MARK: - CollectionView Delegate Flow Layout
extension AppDetailPreviewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  .init(width: view.frame.width / 1.2, height: view.frame.height)
    }
}
