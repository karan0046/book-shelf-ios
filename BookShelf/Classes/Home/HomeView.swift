//
//  HomeView.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var showSidebar = false
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack(spacing: 20) {
                HomeSearchView(searchText: $searchText)
                BookListView(searchText: $searchText)
                Spacer()
            }.tabItem {
                Text("Books")
                Image(systemName: "books.vertical")
            }
            .tag(0)
            
            FavoritiesView()
                .tabItem {
                    Text("Favorities")
                    Image(systemName: "bookmark")
                }
                .tag(1)
            
            ProfileView()
                .tabItem {
                    Text("Profile")
                    Image(systemName: "person.crop.circle")
                }
                .tag(2)
        }
        .navigationTitle(
            getTitle(for: selectedTab)
        )
        .navigationBarBackButtonHidden()
    }
    
    private func getTitle(for tab: Int) -> String {
        switch tab {
        case 0: return "Book Shelf"
        case 1: return "Favorites"
        case 2: return "Profile"
        default: return "Book Shelf"
        }
    }
}


