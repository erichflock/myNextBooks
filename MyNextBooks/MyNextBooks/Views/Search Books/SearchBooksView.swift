//
//  SearchBooksView.swift
//  MyNextBooks
//
//  Created by Erich Flock on 19.09.22.
//

import SwiftUI

struct SearchBooksView: View {
    
    @State private var searchText = ""
    @State private var books: [Book] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink(destination: BookDetailsView(book: book)) {
                        BookCell(book: book)
                    }
                }
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) { _ in
                books.removeAll()
            }
            .onSubmit(of: .search) {
                Task {
                    books = await BooksManager().getBooks(with: searchText)
                }
            }
            .navigationTitle("Search Books")
            .overlay {
                if books.isEmpty {
                    VStack(alignment: .center, spacing: 10) {
                        Image("noSearchResults")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                        Text("No books found. \nPlease search again.")
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .offset(y: -50)
                }
            }
        }
    }
}

struct SearchBooksView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksView()
    }
}

