//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Dhruvil Vyas on 2/13/22.
//

import XCTest
import EssentialFeed

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://www.a-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://www.a-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        
        let (sut, client) = makeSUT()
        var capturedErrors = [RemoteFeedLoader.Error]()
        sut.load { error in
            capturedErrors.append(error)
        }
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        url: URL = URL(string: "https://www.a-url.com")!
    ) -> (RemoteFeedLoader, HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    // MARK: - Spy
    
    private class HTTPClientSpy: HTTPClient {
                    
        var messages = [(requestedURL: URL, completion: (Error) -> Void)]()
        
        var requestedURLs: [URL] {
            messages.map { $0.requestedURL }
        }
        
        func get(
            from url: URL,
            completion: @escaping (Error) -> Void
        ) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, atIndex index: Int = 0) {
            messages[index].completion(error)
        }
    }
}
