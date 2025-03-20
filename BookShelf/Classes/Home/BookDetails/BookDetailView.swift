//
//  BookDetailView.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

struct BookDetailView: View {
    @StateObject var viewModel = BookListViewModel()
    var book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    BookListCellView(book: book)
                        .padding()
                    Spacer()
                }
                BookSummaryView()
                Spacer()
            }
            .navigationTitle("Book Details")
        }
    }
}
