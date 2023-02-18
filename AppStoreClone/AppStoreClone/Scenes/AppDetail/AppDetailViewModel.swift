//
//  AppDetailViewModel.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 18.02.2023.
//

import UIKit

enum AppDetailViewModelState {
    case idle
    case loading(Bool)
    case success
    case failure(NetworkError)
}

final class AppDetailViewModel {

    typealias OnChange = (AppDetailViewModelState) -> Void

    var onChange: OnChange?
    let model: FeedResult
    var results: [SearchResult] = [] {
        didSet {
            emit(state: .success)
        }
    }

    init(model: FeedResult) {
        self.model = model
        self.emit(state: .idle)
    }

    func emit(state: AppDetailViewModelState) {
        self.onChange?(state)
    }

    func fetchAppDetail() {
        guard let appID = model.id else { return }
        NetworkManager.shared.fetchAppDetail(appID: appID) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let response):
                self.results = response.results
            case .failure(let error):
                self.emit(state: .failure(error))
            }
        }
    }

}
