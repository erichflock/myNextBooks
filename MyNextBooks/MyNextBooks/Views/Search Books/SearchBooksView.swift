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
            .navigationTitle(NSLocalizedString("searchBooks", comment: ""))
            .overlay {
                if !network.connected {
                    VStack(alignment: .center, spacing: 10) {
                        Image(systemName: "icloud.slash")
                            .font(.system(size: 60))
                        Text(NSLocalizedString("noInternetMessage", comment: ""))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .offset(y: -50)
                } else if viewModel.books.isEmpty {
                    VStack(alignment: .center, spacing: 10) {
                        Image("noSearchResults")
                            .resizable()
                            .frame(width: 60, height: 60, alignment: .center)
                        Text(NSLocalizedString("noSearchResultsMessage", comment: ""))
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

