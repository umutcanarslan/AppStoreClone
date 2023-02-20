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

enum AppGroupURL: String {
    case tr = "https://rss.applemarketingtools.com/api/v2/tr/apps/top-free/50/apps.json"
    case us = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"
    case en = "https://rss.applemarketingtools.com/api/v2/gb/apps/top-free/10/apps.json"
}

struct NetworkManager {

    static let shared = NetworkManager()

    private init() {}

    func fetchSearchResults(
        with keyword: String,
        completion: @escaping (Result<SearchResultResponse, NetworkError>
        ) -> Void) {
        guard let urlString = "https://itunes.apple.com/search?term=\(keyword)&entity=software".addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) else {
            return completion(.failure(.urlError))
        }

        fetchRequest(urlString: urlString, completion: completion)
    }

    func fetchAppGroup(
        with url: AppGroupURL,
        completion: @escaping (Result<AppGroup, NetworkError>
        ) -> Void) {
        fetchRequest(urlString: url.rawValue, completion: completion)
    }

    func fetchSocialApps(completion: @escaping (Result<[SocialApp], NetworkError>) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchRequest(urlString: urlString, completion: completion)
    }

    func fetchAppDetail(appID: String, completion: @escaping (Result<SearchResultResponse, NetworkError>) -> Void) {
        let urlString = "https://itunes.apple.com/lookup?id=\(appID)"
        fetchRequest(urlString: urlString, completion: completion)
    }

    func fetchAppReview(appID: String, completion: @escaping (Result<Reviews, NetworkError>) -> Void) {
            let urlString = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appID)/sortby=mostrecent/json"
            fetchRequest(urlString: urlString, completion: completion)
        }

    func fetchRequest<T: Decodable>(urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {

        guard let url = URL(string: urlString) else {
            return completion(.failure(.urlError))
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {
                return completion(.failure(.failedToGetData))
            }

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodeError))
            }
        }.resume()
    }

}

