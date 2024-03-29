//
//  MainView.swift
//  MyNextBooks
//
//  Created by Erich Flock on 14.09.22.
//

import SwiftUI

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme
    
    init() {
        if CommandLine.arguments.contains("UITestMode") {
            ReadingListManager.shared.readingList.removeAll()
        }
        UITabBar.appearance().backgroundColor = .secondarySystemFill
    }
    
    var body: some View {
        TabView {
            SearchBooksView()
                .tabItem({
                    Label(NSLocalizedString("search", comment: ""), systemImage: "magnifyingglass.circle.fill")
                        .accessibilityIdentifier("tabBar_searchBooks")
                })
            
            ReadingListView()
                .tabItem({
                    Label(NSLocalizedString("readingList", comment: ""), systemImage: "books.vertical.circle.fill")
                        .accessibilityIdentifier("tabBar_readingList")
                })
        }
        .tint(colorScheme == .light ? .black : .white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
