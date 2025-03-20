//
//  BookListViewModel.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

@MainActor
class BookListViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var bookList = [Book]()
    @Published var years = [String]()
    @Published var cachedDataPresent: Bool = false
    
    let bookListURL: String = "https://www.jsonkeeper.com/b/CNGI"
    
    init() {
        Task {
            await fetchData()
        }
    }
    
    func fetchData() async {
        loading = true
        guard let url = URL(string: bookListURL) else {
            loading = false
            return
        }
        // Check if data is already present in local DB if not then make API call and cache it.
        let bookListData = await Table.Book.fetchAll(filters: nil, sortBy: nil, offset: nil, limit: nil)
        guard !cachedDataPresent, bookListData.isEmpty else {
            loading = false
            cachedDataPresent = true
            return
        }
        // call API to fetch data
        let result = await APIService.shared.executeAPI(url: url)
        guard let data = result as? [[String: Any]] else { return }
        data.forEach { bookJSON in
            let book = Book(json: bookJSON)
            cachedDataPresent = true
            Task {
                await Table.Book.insert(withJson: book.toDic(), docId: book.id) { success, error in
                    guard success else {
                        print(error as Any)
                        return
                    }
                }
            }
        }
        loading = false
    }
    
    func fetchFilteredData(_ filters: [String: Any], searchText: String) async {
        loading = true
        if !cachedDataPresent {
            await fetchData()
        }
        let bookListData = await Table.Book.fetchAll(filters: filters, sortBy: nil, offset: nil, limit: nil)
        bookList.removeAll()
        bookListData.forEach { book in
            bookList.append(Book(json: book))
        }
        if !searchText.isEmpty {
            bookList = bookList.filter { book in
                book.title.contains(searchText)
            }
        }
        loading = false
    }
    
    deinit {
        print("BookListViewModel deallocated")
    }
}
