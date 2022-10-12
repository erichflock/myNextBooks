//
//  MainView.swift
//  MyNextBooks
//
//  Created by Erich Flock on 14.09.22.
//

import SwiftUI

struct MainView: View {
    
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
                    Label("Search", systemImage: "magnifyingglass.circle.fill")
                        .accessibilityIdentifier("tabBar_searchBooks")
                })
            
            ReadingListView()
                .tabItem({
                    Label("Reading List", systemImage: "books.vertical.circle.fill")
                        .accessibilityIdentifier("tabBar_readingList")
                })
        }
        .tint(.black)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
