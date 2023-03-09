//
//  SearchBooksView.swift
//  MyNextBooks
//
//  Created by Erich Flock on 19.09.22.
//

import SwiftUI

struct SearchBooksView: View {
    
    @ObservedObject var viewModel = SearchBooksViewModel()
    @StateObject var network = Network()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.books) { book in
                    NavigationLink(destination: BookDetailsView(book: book)) {
                        BookCell(book: book)
                    }
                }
            }
            .searchable(text: $viewModel.searchText)
            .onChange(of: viewModel.searchText) { _ in
                viewModel.removeBooks()
            }
            .onSubmit(of: .search) {
                Task {
                    await viewModel.searchBooks()
                }
            }
            .navigationTitle("Search Books")
            .overlay {
                if !network.connected {
                    VStack {
                        Text("No intenert.\nPlease check your internet connection.")
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .offset(y: -50)
                } else if viewModel.books.isEmpty {
                    VStack(alignment: .center, spacing: 10) {
                        Image("noSearchResults")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                        Text("No books found.\nPlease search again.")
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .offset(y: -50)
                }
            }
        }
        .onAppear {
            network.checkConnection()
        }
    }
}

struct SearchBooksView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksView()
    }
}

