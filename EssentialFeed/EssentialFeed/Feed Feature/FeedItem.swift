//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Dhruvil Vyas on 2/12/22.
//

import Foundation

public struct FeedItem {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let imageURL: URL
}
