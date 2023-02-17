//
//  AppGroup.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 17.02.2023.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed?
}
struct Feed: Decodable {
    let title: String?
    let results: [FeedResult]?
}
struct FeedResult: Decodable {
    let name, artistName: String?
    let artworkUrl100: URL?
}
