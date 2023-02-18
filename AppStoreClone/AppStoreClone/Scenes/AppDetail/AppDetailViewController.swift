//
//  AppsDetailViewController.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 18.02.2023.
//

import UIKit

class AppDetailViewController: BaseCollectionViewController {

    let viewModel: AppDetailViewModel

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = viewModel.model.name
        navigationItem.largeTitleDisplayMode = .never

        collectionView.register(
            AppDetailCollectionCell.self,
            forCellWithReuseIdentifier: AppDetailCollectionCell.reuseIdentifier
        )

        setupViewModel()
        viewModel.fetchAppDetail()
    }

    init(model: FeedResult) {
        self.viewModel = AppDetailViewModel(model: model)
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewModel() {
        viewModel.onChange = viewObserver
    }

    private func viewObserver(state: AppDetailViewModelState) {
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

//MARK: - CollectionView Data Source
extension AppDetailViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.results.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AppDetailCollectionCell.reuseIdentifier,
            for: indexPath
        ) as? AppDetailCollectionCell else { return .init() }
        
        cell.configure(with: viewModel.results[indexPath.item])
        return cell
    }
}

//MARK: - CollectionView DelegateFlowLayout
extension AppDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let dummyCell = AppDetailCollectionCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
        dummyCell.configure(with: viewModel.results[indexPath.item])
        dummyCell.layoutIfNeeded()

        let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))

        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}
