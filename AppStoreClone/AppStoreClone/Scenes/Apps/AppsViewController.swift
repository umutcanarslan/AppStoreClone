//
//  AppsViewController.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 3.02.2023.
//

import UIKit

final class AppsViewController: BaseCollectionViewController {

    private let viewModel = AppsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Apps"

        collectionView.register(
            AppsGroupCollectionCell.self,
            forCellWithReuseIdentifier: AppsGroupCollectionCell.reuseIdentifier
        )
        collectionView.register(
            AppsHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: AppsHeaderCollectionReusableView.reuseIdentifer
        )

        setupViewModel()
        viewModel.fetchGroups()
    }

    private func setupViewModel() {
        viewModel.onChange = viewObserver
    }

    private func viewObserver(state: AppsViewModelState) {
        switch state {
        case .idle:
            break
        case .loading(let isLoading):
            isLoading ? Hud.show() : Hud.dismiss()
        case .success:
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .failure:
            break
        }
    }

}

//MARK: - Collection View Data Source
extension AppsViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: AppsHeaderCollectionReusableView.reuseIdentifer,
            for: indexPath
        ) as? AppsHeaderCollectionReusableView else { return .init() }

        header.configure(with: viewModel.socialApps)
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsGroupCollectionCell.reuseIdentifier, for: indexPath) as? AppsGroupCollectionCell else { return .init() }
        cell.configure(with: viewModel.model[indexPath.row])
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.model.count
    }
}

//MARK: - Collection View Delegate Flow Layout
extension AppsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
