//
//  SearchViewController.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 3.02.2023.
//

import UIKit

final class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"

        collectionView.backgroundColor = .white
        collectionView.register(
            SearchResultCollectionCell.self,
            forCellWithReuseIdentifier: SearchResultCollectionCell.reuseIdentifier
        )

        setupViewModel()
    }

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewModel() {
        viewModel.onChange = viewObserver
        viewModel.fetchSearchResult()
    }

    private func viewObserver(state: SearchViewModelState) {
        switch state {
        case .idle:
            break
        case .loading:
            break
        case .success:
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .failure:
            break
        }
    }

}

//MARK: Collection View Data Source
extension SearchViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchResultCollectionCell.reuseIdentifier,
            for: indexPath
        ) as! SearchResultCollectionCell
        cell.configure(with: viewModel.getResultItem(at: indexPath.item))
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
}

//MARK: Collection View Delegate
extension SearchViewController {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: view.frame.width, height: 344)
    }
}
