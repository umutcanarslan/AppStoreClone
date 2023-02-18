//
//  AppsHorizontalViewController.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 4.02.2023.
//

import UIKit

typealias DidSelectItem = (FeedResult) -> ()

enum Spacing {
    static let topBottomPadding: CGFloat = 16
    static let minimumLineSpacing: CGFloat = 12
}

class AppsHorizontalViewController: HorizontalSnappingController {


    private var results: [FeedResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    var didSelectHandler: DidSelectItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(
            AppsRowCollectionCell.self,
            forCellWithReuseIdentifier: AppsRowCollectionCell.reuseIdentifier
        )

        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func configure(with model: [FeedResult]) {
        results = model
    }
    
}

//MARK: - Collection View Data Source
extension AppsHorizontalViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AppsRowCollectionCell.reuseIdentifier,
            for: indexPath
        ) as? AppsRowCollectionCell else { return .init() }
        
        cell.configure(with: results[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
}

//MARK: - CollectionView Delegate
extension AppsHorizontalViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let app = results[indexPath.item]
        didSelectHandler?(app)
    }
}

//MARK: - Collection View Delegate Flow Layout
extension AppsHorizontalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let height = (view.frame.height - (2 * Spacing.topBottomPadding) - (2 * Spacing.minimumLineSpacing)) / 3
        return .init(width: view.frame.width - 48, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Spacing.minimumLineSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Spacing.minimumLineSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return .init(top: Spacing.topBottomPadding, left: 0, bottom: Spacing.topBottomPadding, right: 0)
    }
}
