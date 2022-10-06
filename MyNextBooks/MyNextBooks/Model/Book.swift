//
//  Book.swift
//  MyNextBooks
//
//  Created by Erich Flock on 19.09.22.
//

import Foundation

struct Book: Identifiable {
    let id = UUID()
    var title: String
    var authors: String
    var imageUrl: String?
    var publishedDate: String?
    var description: String?
    
    func getSecureImageUrl() -> String? {
        guard let imageUrl = imageUrl,
              imageUrl.contains("http://") else {
            return imageUrl
        }
        return imageUrl.replacingOccurrences(of: "http", with: "https")
    }
}
