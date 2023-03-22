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
                .onDelete(perform: readingManager.delete)
            }
            .navigationTitle(NSLocalizedString("readingList", comment: ""))
            .overlay {
                if readingManager.readingList.isEmpty {
                    VStack(alignment: .center, spacing: 10) {
                        Image("emptyLibrary")
                            .resizable()
                            .frame(width: 60, height: 60, alignment: .center)
                        Text(NSLocalizedString("noBooksMessage", comment: ""))
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
