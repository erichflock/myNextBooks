//
//  BookApiModel+Fixture.swift
//  MyNextBooksTests
//
//  Created by Erich Flock on 28.09.22.
//

@testable import MyNextBooks
import Foundation

extension BookApiModel {
    
    static func fixture(totalItems: Int? = 0,
                        items: [Item]? = []) -> Self {
        .init(totalItems: 0, items: items)
    }
    
}

extension BookApiModel.Item {
    
    static func fixture(id: String? = UUID().uuidString,
                        volumeInfo: VolumeInfo?,
                        saleInfo: SaleInfo? = nil) -> Self {
        .init(id: id, volumeInfo: volumeInfo, saleInfo: saleInfo)
    }
    
}

extension BookApiModel.Item.VolumeInfo {
    
    static func fixture(title: String? = "title",
                        authors: [String]? = [],
                        subtitle: String? = "subtitle",
                        publishedDate: String? = nil,
                        description: String? = nil,
                        imageLinks: ImageLinks? = nil,
                        pageCount: Int? = nil,
                        language: String? = nil,
                        publisher: String? = nil
    ) -> Self {
        .init(title: title, authors: authors, subtitle: subtitle, publishedDate: publishedDate, description: description, imageLinks: imageLinks, pageCount: pageCount, language: language, publisher: publisher)
    }
    
}

extension BookApiModel.Item.VolumeInfo.ImageLinks {
    
    static func fixture(smallThumbnail: String? = "smallThumbnail",
                        thumbnail: String? = "thumbnail") -> Self {
        .init(smallThumbnail: smallThumbnail, thumbnail: thumbnail)
    }
    
}
