//
//  BaseCollectionViewController.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 4.02.2023.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
