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
            AsyncImage(url: URL(string: book.getSecureImageUrl() ?? "")) { image in
                image
                    .formattedImage(width: 50, height: 75)
                    
            } placeholder: {
                Image(systemName: "book")
                    .formattedImage(width: 50, height: 75)
            }
            
            Text(book.title)
        }
    }
}

struct BookCell_Previews: PreviewProvider {
    static var previews: some View {
        BookCell(book: .init(id: "id", title: "Book Title", authors: "authors", imageUrl: ""))
    }
}
