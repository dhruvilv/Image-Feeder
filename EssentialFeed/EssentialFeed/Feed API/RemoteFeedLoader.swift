//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Dhruvil Vyas on 2/13/22.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (Error) -> Void)
}

public final class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    
    public enum Error {
        case connectivity
    }
    
    public init(
        url: URL = URL(string: "https://a-url.com")!,
        client: HTTPClient
    ) {
        self.client = client
        self.url = url
    }
    
    public func load(
completion: @escaping (RemoteFeedLoader.Error) -> Void = { _ in }
    ) {
        client.get(from: url) { error in
            completion(.connectivity)
        }
    }
}
