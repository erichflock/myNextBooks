//
//  SearchBooksViewModel.swift
//  MyNextBooks
//
//  Created by Erich Flock on 24.02.23.
//

import SwiftUI

class SearchBooksViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published var books: [Book] = []
}
