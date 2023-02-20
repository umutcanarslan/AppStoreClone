//
//  SearchViewModel.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 4.02.2023.
//

import Foundation

typealias OnChange = (SearchViewModelState) -> Void

enum SearchViewModelState {
    case idle
    case loading(Bool)
    case success
    case failure(NetworkError)
}

final class SearchViewModel {

    var appResult: [SearchResult] = []
    var onChange: OnChange?
    var keyword: String? {
        didSet {
            fetchSearchResult()
        }
    }

    var numberOfItems: Int {
        appResult.count
    }

    init() {
        emit(state: .idle)
    }

    func emit(state: SearchViewModelState) {
        self.onChange?(state)
    }

    func getResultItem(at index: Int) -> SearchResult {
        return appResult[index]
    }

    fileprivate func fetchSearchResult() {
        if keyword.isNilOrEmpty {
            removeResults()
            return
        }

        emit(state: .loading(true))

        NetworkManager.shared.fetchSearchResults(with: keyword ?? "") { [weak self] result in
            guard let self = self else { return }
            self.emit(state: .loading(false))

            switch result {
            case .success(let response):
                self.appResult = response.results
                self.emit(state: .success)
            case .failure(let error):
                self.emit(state: .failure(error))
            }
        }
    }

    private func removeResults() {
        appResult = []
        self.emit(state: .success)
    }

}
