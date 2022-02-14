//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Dhruvil Vyas on 2/13/22.
//

import XCTest
import EssentialFeed

class HTTPClientSpy: HTTPClient {
    
    var requestedURL: URL?
    var requestedURLCallCount = 0
    
    func get(from url: URL) {
        requestedURLCallCount += 1
        requestedURL = url
    }
}

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://www.a-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load()
        XCTAssertNotNil(client.requestedURL)
        XCTAssertEqual(client.requestedURL, URL(string: "https://www.a-url.com")!)
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://www.a-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load()
        sut.load()
        XCTAssertNotNil(client.requestedURL)
        XCTAssertEqual(client.requestedURLCallCount, 2)
        XCTAssertEqual(client.requestedURL, URL(string: "https://www.a-url.com")!)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        url: URL = URL(string: "https://www.a-url.com")!
    ) -> (RemoteFeedLoader, HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
}
