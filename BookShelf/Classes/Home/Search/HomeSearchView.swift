//
//  HomeSearchView.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

struct HomeSearchView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search", text: $searchText)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(15)
        }
        .padding(.horizontal)
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.leading, 15)
        .padding(.trailing, 15)
    }
}
