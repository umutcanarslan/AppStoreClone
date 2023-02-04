//
//  NetworkManager.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 4.02.2023.
//

import Foundation

enum NetworkError: Error {
    case failedToGetData
    case decodeError
    case urlError
}

struct NetworkManager {

    static let shared = NetworkManager()

    private init() {}

    func fetchApps(
        with keyword: String,
        completion: @escaping (Result<SearchResultResponse, NetworkError>) -> Void) {
            guard let urlString = "https://itunes.apple.com/search?term=\(keyword)&entity=software".addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) else {
                return completion(.failure(.urlError))
            }

            guard let url = URL(string: urlString) else {
                return completion(.failure(.urlError))
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data , error == nil else {
                    return completion(.failure(.failedToGetData))
                }

                do {
                    let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodeError))
                }

            }.resume()
        }

}
