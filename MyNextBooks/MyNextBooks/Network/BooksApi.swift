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

enum BooksApiError: LocalizedError {
    case invalidUrl
    case invalidResponse
    case decodingFailed(underlying: Error)
    case requestFailed(statusCode: Int, message: String?)

    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "The search URL is invalid."
        case .invalidResponse:
            return "The book search returned an unexpected response."
        case .decodingFailed(let underlying):
            return underlying.localizedDescription
        case .requestFailed(_, let message):
            return message ?? "The book search failed."
        }
    }
}

class BooksApi: BooksApiProtocol {
    private let googleBooksAPIKey = ""
    private let baseURL = "https://www.googleapis.com/books/v1/volumes"
    
    func getBooks(with terms: String) async throws -> BookApiModel? {
        var lastError: Error?
        for attempt in 0..<3 {
            do {
                return try await fetchBooks(with: terms)
            } catch let error as BooksApiError {
                lastError = error
                guard case .requestFailed(let statusCode, _) = error,
                      statusCode == 429 || statusCode == 503,
                      attempt < 2 else {
                    throw error
                }
                try await Task.sleep(nanoseconds: UInt64(attempt + 1) * 400_000_000)
            }
        }
        throw lastError ?? BooksApiError.requestFailed(statusCode: 503, message: nil)
    }

    private func fetchBooks(with terms: String) async throws -> BookApiModel {
        let queryItems = [
            URLQueryItem(name: "q", value: terms),
            URLQueryItem(name: "key", value: googleBooksAPIKey)
        ]
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = queryItems

        guard let url = urlComponents?.url else { throw BooksApiError.invalidUrl }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw BooksApiError.invalidResponse
        }
        return try decodeBooks(from: data, statusCode: httpResponse.statusCode)
    }

    private func decodeBooks(from data: Data, statusCode: Int) throws -> BookApiModel {
        guard (200..<300).contains(statusCode) else {
            let message = GoogleBooksErrorBody.message(from: data)
            throw BooksApiError.requestFailed(statusCode: statusCode, message: message)
        }
        do {
            let decoded = try JSONDecoder().decode(LossyVolumesResponse.self, from: data)
            return BookApiModel(totalItems: decoded.totalItems, items: decoded.items)
        } catch {
            throw BooksApiError.decodingFailed(underlying: error)
        }
    }
    
}

private struct GoogleBooksErrorBody: Decodable {
    struct APIError: Decodable {
        let message: String?
    }

    let error: APIError

    static func message(from data: Data) -> String? {
        try? JSONDecoder().decode(GoogleBooksErrorBody.self, from: data).error.message
    }
}

private struct LossyVolumesResponse: Decodable {
    let totalItems: Int?
    let items: [BookApiModel.Item]

    private struct FailableItem: Decodable {
        let item: BookApiModel.Item?

        init(from decoder: Decoder) throws {
            item = try? BookApiModel.Item(from: decoder)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case totalItems
        case items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        totalItems = try container.decodeIfPresent(Int.self, forKey: .totalItems)
        let wrapped = try container.decodeIfPresent([FailableItem].self, forKey: .items) ?? []
        items = wrapped.compactMap(\.item)
    }
}

struct BookApiModel: Codable {
    
    var totalItems: Int?
    var items: [Item]?
    
    struct Item: Codable {
        
        var id: String?
        var volumeInfo: VolumeInfo?
        var saleInfo: SaleInfo?
        
        struct VolumeInfo: Codable {
            var title: String?
            var authors: [String]?
            var subtitle: String?
            var publishedDate: String?
            var description: String?
            var imageLinks: ImageLinks?
            var pageCount: Int?
            var language: String?
            var publisher: String?
            
            struct ImageLinks: Codable {
                var smallThumbnail: String?
                var thumbnail: String?
            }
        }
        
        struct SaleInfo: Codable {
            var listPrice: ListPrice?
            
            struct ListPrice: Codable {
                var amount: Double?
                var currencyCode: String?
            }
        }
    }
}
