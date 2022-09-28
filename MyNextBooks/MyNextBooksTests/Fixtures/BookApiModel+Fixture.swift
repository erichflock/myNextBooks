//
//  BookApiModel+Fixture.swift
//  MyNextBooksTests
//
//  Created by Erich Flock on 28.09.22.
//

@testable import MyNextBooks

extension BookApiModel {
    
    static func fixture(totalItems: Int? = 0,
                        items: [Item]? = []) -> Self {
        .init(totalItems: 0, items: items)
    }
    
}

extension BookApiModel.Item {
    
    static func fixture(id: String? = "id",
                        volumeInfo: VolumeInfo?) -> Self {
        .init(id: id, volumeInfo: volumeInfo)
    }
    
}

extension BookApiModel.Item.VolumeInfo {
    
    static func fixture(title: String? = "title",
                        authors: [String]? = [],
                        subtitle: String? = "subtitle",
                        publishedDate: String? = "01.01.200",
                        description: String? = "description",
                        imageLinks: ImageLinks? = nil) -> Self {
        .init(title: title, authors: authors, subtitle: subtitle, publishedDate: publishedDate, description: description, imageLinks: imageLinks)
    }
    
}

extension BookApiModel.Item.VolumeInfo.ImageLinks {
    
    static func fixture(smallThumbnail: String? = "smallThumbnail",
                        thumbnail: String? = "thumbnail") -> Self {
        .init(smallThumbnail: smallThumbnail, thumbnail: thumbnail)
    }
    
}
