//
//  AppsViewController.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 3.02.2023.
//

import UIKit

final class AppsViewController: BaseCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(AppsGroupCollectionCell.self, forCellWithReuseIdentifier: AppsGroupCollectionCell.reuseIdentifier)
        navigationItem.title = "Apps"
    }

}

//MARK: - Collection View Data Source
extension AppsViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AppsGroupCollectionCell.reuseIdentifier,
            for: indexPath
        )
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}

//MARK: - Collection View Delegate Flow Layout
extension AppsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
}

