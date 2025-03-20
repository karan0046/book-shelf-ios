//
//  BookListCellViewModel.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

@MainActor
class BookListCellViewModel: ObservableObject {
    
    @Published var processing: Bool = false
    @Published var bookmarked: Bool = false
    
    init() {
        
    }
    
    func fetchBookmarkState(_ book: Book) async {
        let exits = await Table.BookMark.exists(withId: book.id)
        bookmarked = exits
    }
    
    func updateBookmark(_ book: Book, bookmark: Bool) async {
        processing = true
        if bookmark {
            await Table.BookMark.insert(withJson: ["id": book.id], docId: book.id) { success, error in
                guard success else {
                    print(error as Any)
                    return
                }
            }
        } else {
            await Table.BookMark.delete(withId: book.id) { success, error in
                guard success else {
                    print(error as Any)
                    return
                }
            }
        }
        processing = false
        bookmarked = bookmark
    }
    
    deinit {
        print("BookListCellViewModel deallocated")
    }
}
