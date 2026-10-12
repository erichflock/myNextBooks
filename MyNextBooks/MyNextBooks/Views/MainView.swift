//
//  MainView.swift
//  MyNextBooks
//
//  Created by Erich Flock on 14.09.22.
//

import SwiftUI

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab = 1
    
    init() {
        if CommandLine.arguments.contains("UITestMode") {
            ReadingListManager.shared.readingList.removeAll()
        }
        UITabBar.appearance().backgroundColor = .secondarySystemFill
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SearchBooksView()
                .tabItem({
                    Label(NSLocalizedString("search", comment: ""), systemImage: "magnifyingglass.circle.fill")
                        .accessibilityIdentifier("tabBar_searchBooks")
                })
                .tag(0)
            ReadingListView()
                .tabItem({
                    Label(NSLocalizedString("readingList", comment: ""), systemImage: "books.vertical.circle.fill")
                        .accessibilityIdentifier("tabBar_readingList")
                })
                .tag(1)
        }
        .tint(colorScheme == .light ? .black : .white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
