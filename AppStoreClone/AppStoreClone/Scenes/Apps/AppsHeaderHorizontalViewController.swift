//
//  AppsHeaderHorizontalViewController.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 17.02.2023.
//

import UIKit

class AppsHeaderHorizontalViewController: HorizontalSnappingController {

    private var model = [SocialApp]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(
            AppsHeaderCollectionCell.self,
            forCellWithReuseIdentifier: AppsHeaderCollectionCell.reuseIdentifier
        )

        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    func configure(with model: [SocialApp]) {
        self.model = model
    }

}

//MARK: - CollectionView DataSource
extension AppsHeaderHorizontalViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AppsHeaderCollectionCell.reuseIdentifier,
            for: indexPath
        ) as? AppsHeaderCollectionCell else { return .init() }
        cell.configure(with: model[indexPath.item])
        return cell
    }
}

//MARK: - CollectionView DelegateFlowLayout
extension AppsHeaderHorizontalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        insetForSectionAt section: Int
//    ) -> UIEdgeInsets {
//        return .init(top: 0, left: 16, bottom: 0, right: 16)
//    }
}
