//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Dhruvil Vyas on 2/13/22.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (Error?, Int?) -> Void)
}

public final class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    
    public enum Error {
        case connectivity
        case invalidResponse
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
        client.get(from: url) { error, code in
            if error != nil {
                completion(.connectivity)
            } else {
                completion(.invalidResponse)
            }
        }
    }
}
