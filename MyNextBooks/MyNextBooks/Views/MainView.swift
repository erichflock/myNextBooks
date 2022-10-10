//
//  MainView.swift
//  MyNextBooks
//
//  Created by Erich Flock on 14.09.22.
//

import SwiftUI

struct MainView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = .secondarySystemFill
    }
    
    var body: some View {
        TabView {
            SearchBooksView()
                .tabItem({
                    Label("Search Books", systemImage: "magnifyingglass.circle.fill")
                })
            
            ReadingListView()
                .tabItem({
                    Label("Reading List", systemImage: "books.vertical.circle.fill")
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
