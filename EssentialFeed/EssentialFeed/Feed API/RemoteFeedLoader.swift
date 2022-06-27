//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Dhruvil Vyas on 2/13/22.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure
}

public final class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    
    public enum RemoteFeedLoaderResult {
        case success([FeedItem])
        case failure(Error)
    }
    
    public enum Error {
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
        completion: @escaping (RemoteFeedLoader.Error) -> Void
    ) {
        client.get(from: url) { result in
            switch result {
            case let .success(response, data):
                completion(.invalidData)
            case .failure:
                completion(.connectivity)
            }
        }
    }
}
