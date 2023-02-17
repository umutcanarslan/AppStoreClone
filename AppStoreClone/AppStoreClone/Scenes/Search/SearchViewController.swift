//
//  SearchViewController.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 3.02.2023.
//

import UIKit

final class SearchViewController: BaseCollectionViewController {

    let viewModel = SearchViewModel()
    fileprivate var timer = Timer()
    fileprivate let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"

        setupSearchBar()

        collectionView.backgroundColor = .white
        collectionView.register(
            SearchResultCollectionCell.self,
            forCellWithReuseIdentifier: SearchResultCollectionCell.reuseIdentifier
        )

        setupViewModel()
    }

    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }

    private func setupViewModel() {
        viewModel.onChange = viewObserver
        viewModel.keyword = ""
        
    }

    private func viewObserver(state: SearchViewModelState) {
        switch state {
        case .idle:
            break
        case .loading(let loading):
            DispatchQueue.main.async {
                loading ? Hud.show() : Hud.dismiss()
            }
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

//MARK: Collection View Delegate Flow Layout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: view.frame.width, height: 344)
    }
}

//MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in
            self.viewModel.keyword = searchText
        })
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.keyword = ""
    }
}
