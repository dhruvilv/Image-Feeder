//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Dhruvil Vyas on 2/13/22.
//

import Foundation

class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    
    init(
        url: URL = URL(string: "https://a-url.com")!,
        client: HTTPClient
    ) {
        self.client = client
        self.url = url
    }
    
    func load() {
        client.get(from: url)
    }
}

public protocol HTTPClient {
    func get(from url: URL)
}
