//
//  SearchBooksView.swift
//  MyNextBooks
//
//  Created by Erich Flock on 19.09.22.
//

import SwiftUI

struct SearchBooksView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                
            }
            .searchable(text: $searchText)
            .navigationTitle("Search Books")
        }
    }
}

struct SearchBooksView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksView()
    }
}
