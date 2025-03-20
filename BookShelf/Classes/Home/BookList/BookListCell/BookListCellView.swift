//
//  BookListCellView.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

struct BookListCellView: View {
    @StateObject var viewModel = BookListCellViewModel()
    @State var isBookmarked: Bool = false
    
    var book: Book
    init(book: Book) {
        self.book = book
    }
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: book.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 120)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 120)
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 80, height: 120)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text("⭐ \(book.popularity)")
                    .foregroundColor(.orange)
                Text("Published in \(formatDate(from: book.publishedChapterDate))")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Bookmark Button
            Button(action: {
                Task {
                    await viewModel.updateBookmark(book, bookmark: !isBookmarked)
                }
            }) {
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(isBookmarked ? Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)) : .gray)
                    .imageScale(.large)
            }
            .buttonStyle(.plain)
            .onChange(of: viewModel.bookmarked) { oldValue, newValue in
                isBookmarked = newValue
                Task {
                    await viewModel.fetchBookmarkState(book)
                }
            }.onAppear {
                Task {
                    await viewModel.fetchBookmarkState(book)
                }
            }
            
        }
        .padding(.vertical, 8)
    }
}
