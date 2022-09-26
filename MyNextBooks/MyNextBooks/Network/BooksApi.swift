//
//  BooksAPI.swift
//  MyNextBooks
//
//  Created by Erich Flock on 23.09.22.
//

import Foundation

protocol BooksApiProtocol {
    func getBooks(with terms: String) async throws -> BookApiModel?
}

enum BooksApiError: Error {
    case invalidUrl
    case decodeError
}

class BooksApi: BooksApiProtocol {
    
    let baseURL = "https://www.googleapis.com/books/v1/volumes"
    
    func getBooks(with terms: String) async throws -> BookApiModel? {
        let queryItems = [URLQueryItem(name: "q", value: terms)]
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { throw BooksApiError.invalidUrl }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        var result: BookApiModel?
        do {
            result = try JSONDecoder().decode(BookApiModel.self, from: data)
        } catch {
            throw BooksApiError.decodeError
        }
        return result
    }
    
}

struct BookApiModel: Codable {
    
    var totalItems: Int?
    var items: [Item]?
    
    struct Item: Codable {
        
        var id: String?
        var volumeInfo: VolumeInfo?
        
        struct VolumeInfo: Codable {
            var title: String?
            var authors: [String]?
            var subtitle: String?
            var publishedDate: String?
            var description: String?
            var imageLinks: ImageLinks?
            
            struct ImageLinks: Codable {
                var smallThumbnail: String?
                var thumbnail: String?
            }
        }
    }
}
