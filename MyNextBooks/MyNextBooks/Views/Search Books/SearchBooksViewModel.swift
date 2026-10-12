//
//  SearchBooksViewModel.swift
//  MyNextBooks
//
//  Created by Erich Flock on 24.02.23.
//

import SwiftUI

class SearchBooksViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published private(set) var books: [Book] = []
    @Published private(set) var errorMessage: String?
    
    var booksManager = BooksManager()
    
    @MainActor //Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
    func searchBooks() async {
        do {
            books = try await booksManager.getBooks(with: searchText)
            errorMessage = nil
        } catch {
            books = []
            errorMessage = error.localizedDescription
        }
    }
    
    func removeBooks() {
        books.removeAll()
        errorMessage = nil
    }
}
