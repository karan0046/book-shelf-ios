//
//  Fa.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

@MainActor
class FavoritiesViewModel: ObservableObject {
    
    @Published var loading: Bool = false
    @Published var bookmarkList = [Book]()
    
    init() {
        
    }
    
    func fetchData() async {
        loading = true
        let records = await Table.BookMark.fetchAll(filters: nil, sortBy: nil, offset: nil, limit: nil)
        guard !records.isEmpty else {
            loading = false
            return
        }
        bookmarkList.removeAll()
        var ids = [String]()
        records.forEach { record in
            guard let id = record["id"] as? String else { return }
            ids.append(id)
        }
        let bookData = await Table.Book.fetchAll(filters: ["id": FilterOperator.in_ls.value(ids)], sortBy: nil, offset: nil, limit: nil)
        bookData.forEach { book in
            bookmarkList.append(Book(json: book))
        }
        loading = false
    }
    
    deinit {
        print("FavoritiesViewModel deallocated")
    }
}
