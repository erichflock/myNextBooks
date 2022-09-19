//
//  BookCell.swift
//  MyNextBooks
//
//  Created by Erich Flock on 19.09.22.
//

import SwiftUI

struct BookCell: View {
    
    @State var book: Book
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: "book")
                .resizable()
                .frame(width: 40, height: 50) //TODO: To be adjusted
            Text(book.title)
        }
    }
}

struct BookCell_Previews: PreviewProvider {
    static var previews: some View {
        BookCell(book: .init(title: "Book Title", imageUrl: ""))
    }
}
