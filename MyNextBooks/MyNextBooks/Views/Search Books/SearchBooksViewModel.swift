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
    
    func searchBooks() async {
        books = await BooksManager().getBooks(with: searchText)
    }
    
    func removeBooks() {
        books.removeAll()
    }
}
