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
    
    @MainActor //Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
    func searchBooks() async {
        Task {
            books = await BooksManager().getBooks(with: searchText)
        }
    }
    
    func removeBooks() {
        books.removeAll()
    }
}
