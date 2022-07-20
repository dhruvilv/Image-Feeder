//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Dhruvil Vyas on 2/13/22.
//

import Foundation

public final class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    
    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(
        url: URL = URL(string: "https://a-url.com")!,
        client: HTTPClient
    ) {
        self.client = client
        self.url = url
    }
    
    public func load(
        completion: @escaping (Result) -> Void
    ) {
        client.get(from: url) { result in
            switch result {
            case let .success(data, response):
                if let items = try? FeedItemsMapper.map(data, response) {
                    completion(.success(items))
                }
                else {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}
