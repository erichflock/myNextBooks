//
//  BookDetailsView.swift
//  MyNextBooks
//
//  Created by Erich Flock on 06.10.22.
//

import SwiftUI

struct BookDetailsView: View {
    
    let book: Book
    @State var isSelected = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 8) {
                AsyncImage(url: URL(string: book.getSecureImageUrl() ?? "")) { image in
                    image
                        .resizable()
                } placeholder: {
                    Image(systemName: "book")
                        .resizable()
                }
                .frame(width: 128, height: 192)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(book.title)
                    .font(.title2)
                HStack(alignment: .center) {
                    Spacer()
                    VStack {
                        Text(book.authors)
                            .font(.title3)
                            .foregroundColor(.secondary)
                        Text(book.getFormattedPublishedDate() ?? "")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Button {
                        isSelected.toggle()
                    } label: {
                        Image(systemName: isSelected ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.init("wine"))
                            .padding(.trailing, 10)
                    }
                }
                Text(book.description ?? "")
                    .font(.body)
                Spacer()
            }
            .padding()
        }
    }
}

struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailsView(book: .init(title: "", authors: ""))
    }
}
