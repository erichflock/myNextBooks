//
//  Book.swift
//  MyNextBooks
//
//  Created by Erich Flock on 19.09.22.
//

import Foundation

struct Book: Identifiable, Equatable, Codable {
    let id: String
    var title: String
    var authors: String
    var imageUrl: String?
    var publishedDate: String?
    var description: String?
    var pageCount: Int?
    var language: String?
    var publisher: String?
    var price: String?
    
    func getSecureImageUrl() -> String? {
        guard let imageUrl = imageUrl,
              imageUrl.contains("http://") else {
            return imageUrl
        }
        return imageUrl.replacingOccurrences(of: "http", with: "https")
    }
    
    func getFormattedPublishedDate(locale: Locale = .current) -> String? {
        guard let publishedDate = publishedDate else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = locale
        
        let desiredDateFormatter = DateFormatter()
        desiredDateFormatter.dateFormat = "MMM yyyy"
        desiredDateFormatter.locale = locale
        
        guard let dateFromString = dateFormatter.date(from: publishedDate) else { return nil }
        return desiredDateFormatter.string(from: dateFromString)
    }
}

extension Book {
    
    struct CKKeys {
        static let id = "id"
        static let title = "title"
        static let authors = "authors"
        static let imageUrl = "imageUrl"
        static let publishedDate = "publishedDate"
        static let description = "description"
    }
    
    struct CKRecordType {
        static let value = "Book"
    }
}
