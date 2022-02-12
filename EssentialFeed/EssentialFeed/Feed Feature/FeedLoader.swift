//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Dhruvil Vyas on 2/12/22.
//

import Foundation

case LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
