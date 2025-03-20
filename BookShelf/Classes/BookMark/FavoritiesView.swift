//
//  FavoritiesView.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

struct FavoritiesView: View {
    @StateObject var viewModel = FavoritiesViewModel()
    
    var body: some View {
        VStack {
            if viewModel.loading {
                HStack {
                    Spacer()
                    ProgressView("Loading...")
                    Spacer()
                }
            } else {
                if viewModel.bookmarkList.isEmpty {
                    Text("No Data Available")
                } else {
                    List(viewModel.bookmarkList) { book in
                        BookListCellView(book: book)
                    }
                }
            }
        }
        .onAppear(perform: {
            Task {
                await viewModel.fetchData()
            }
        })
        .frame(maxWidth: .infinity)
    }
}
