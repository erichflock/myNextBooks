//
//  ReadingListView.swift
//  MyNextBooks
//
//  Created by Erich Flock on 07.10.22.
//

import SwiftUI

struct ReadingListView: View {
    
    @ObservedObject var readingManager = ReadingListManager.shared
    
    var body: some View {
        NavigationView {
            List {
                ForEach(readingManager.readingList) { book in
                    NavigationLink(destination: BookDetailsView(book: book)) {
                        BookCell(book: book)
                    }
                }
            }
            .navigationTitle("Reading List")
            .overlay {
                if readingManager.readingList.isEmpty {
                    VStack(alignment: .center, spacing: 10) {
                        Image("bookShelf")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                        Text("No books. \nPlease add books to your list.")
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .offset(y: -30)
                    .accessibilityIdentifier("readingList_emptyStateView")
                }
            }
        }
    }
}

struct ReadingListView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingListView()
    }
}
