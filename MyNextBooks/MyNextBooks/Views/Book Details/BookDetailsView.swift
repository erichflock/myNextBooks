//
//  BookDetailsView.swift
//  MyNextBooks
//
//  Created by Erich Flock on 06.10.22.
//

import SwiftUI

struct BookDetailsView: View {
    
    let book: Book
    @ObservedObject var readingManager = ReadingListManager.shared
    @State private var isExpanded = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 8) {
                VStack(alignment: .center, spacing: 8) {
                    AsyncImage(url: URL(string: book.getSecureImageUrl() ?? "")) { image in
                        image
                            .formattedImage(width: 128, height: 192)
                    } placeholder: {
                        Image(systemName: "book")
                            .formattedImage(width: 128, height: 192)
                    }
                    
                    Text(book.title)
                        .font(.title2)
                    HStack(alignment: .center) {
                        Spacer()
                        VStack {
                            Text(book.authors)
                                .font(.title3)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button {
                            readingManager.readingList.contains(book) ? readingManager.remove(book: book) : readingManager.add(book: book)
                        } label: {
                            Image(systemName: readingManager.readingList.contains(book) ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.init("wine"))
                                .padding(.trailing, 10)
                        }
                        .accessibilityIdentifier("bookDetails_heartButton")
                    }
                    
                    if let description = book.description {
                        CollapsibleTextView(
                            text: description,
                            lineLimit: 5,
                            isExpanded: isExpanded
                        )
                        .onTapGesture {
                            isExpanded.toggle()
                        }
                    }
                }
                .padding(.horizontal)
                
                AdditionalDetailsBookDetailsView(additionalDetails: additionalDetails())
                    .padding(.top, 24)
                //Spacer()
            }
            .padding(.bottom)
        }
    }
    
    private func additionalDetails() -> [AdditionalDetailsBookDetailsView.AdditionalDetail] {
        var details: [AdditionalDetailsBookDetailsView.AdditionalDetail] = []
        if let publisher = book.publisher {
            details.append(.init(systemImageName: "building.2", title: publisher))
        }
        if let pageCount = book.pageCount?.description {
            details.append(.init(systemImageName: "ruler", title: "\(pageCount)\n\(NSLocalizedString("pages", comment: "Pages"))"))
        }
        if let publishedDate = book.getFormattedPublishedDate() {
            details.append(.init(systemImageName: "calendar", title: publishedDate))
        }
        if let price = book.price {
            details.append(.init(systemImageName: "banknote", title: price))
        }
        if let language = book.language {
            details.append(.init(systemImageName: "globe", title: language))
        }
        return details
    }
}

struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailsView(
            book: .init(
                id: "id",
                title: "Sapiens",
                authors: "Yuval Noah Harari",
                publishedDate: "2000-04-01",
                description: "Der Millionenseller jetzt aktualisiert und mit neuem Nachwort. Vor 100.000 Jahren lebte Homo Sapiens als unbedeutende Spezies in einem abgelegenen Winkel des afrikanischen Kontinents. Heute ist der Mensch Herr und Schrecken des Planeten. Wie konnte es dazu kommen? In seiner fulminanten Reise von den Menschenaffen bis zum Cyborg entwirft Yuval Noah Harari mit seinem international gefeierten Bestseller »Sapiens - Eine kurze Geschichte der Menschheit« das große Panorama unserer eigenen Geschichte – und stellt die Frage, wohin wir von hier aus gehen wollen. »Sapiens« ist einer der größten Sachbucherfolge aller Zeiten und hat allein in Deutschland, bisher unter dem Titel »Eine kurze Geschichte der Menschheit«, über 2 Millionen Exemplare verkauft. Dieser immense Erfolg ist kein Zufall: Das Buch hat von Grund auf verändert, welche Verantwortung wir als Menschen gegenüber unseren Mitgeschöpfen und dem Planeten empfinden – und wie wir handeln. Yuval Noah Harari schreibt präzise, klug – und vor allem so, dass man gar nicht aufhören will zu lesen. Dieses Buch lässt Hirne wachsen.« ZEIT WISSEN. Das Buch erschien erstmals 2013 unter dem Titel »Eine kurze Geschichte der Menschheit« bei DVA. Diese neue Ausgabe ist aktualisiert und um ein neues Nachwort ergänzt. Mit zahlreichen Abbildungen",
                pageCount: 325,
                language: "DE",
                publisher: "Campus Verlag",
                price: "19,99 €"
            )
        )
    }
}
