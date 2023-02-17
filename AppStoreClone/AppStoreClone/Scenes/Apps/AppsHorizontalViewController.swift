//
//  AppsHorizontalViewController.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 4.02.2023.
//

import UIKit

enum Spacing {
    static let topBottomPadding: CGFloat = 16
    static let minimumLineSpacing: CGFloat = 8
}

class AppsHorizontalViewController: BaseCollectionViewController {
    
    private var results: [FeedResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(
            AppsRowCollectionCell.self,
            forCellWithReuseIdentifier: AppsRowCollectionCell.reuseIdentifier
        )
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
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
        return .init(top: Spacing.topBottomPadding, left: 16, bottom: Spacing.topBottomPadding, right: 16)
    }
}
