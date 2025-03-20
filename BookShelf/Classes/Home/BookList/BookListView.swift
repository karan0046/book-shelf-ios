//
//  BookListView.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

struct BookListView: View {
    @StateObject var viewModel = BookListViewModel()
    @State var selecedYear: String = ""
    @Binding var searchText: String
    
    var body: some View {
        NavigationStack {
            BookYearView(selectedYear: $selecedYear)
                .onChange(of: selecedYear) { oldValue, newValue in
                    Task {
                        await viewModel.fetchFilteredData([ "publishedChapterYear" : FilterOperator.eq.value(selecedYear)], searchText: searchText)
                    }
                }.onChange(of: searchText) { oldValue, newValue in
                    Task {
                        await viewModel.fetchFilteredData([ "publishedChapterYear" : FilterOperator.eq.value(selecedYear)], searchText: searchText)
                    }
                }.onChange(of: viewModel.cachedDataPresent) { oldValue, newValue in
                    Task {
                        await viewModel.fetchFilteredData([ "publishedChapterYear" : FilterOperator.eq.value(selecedYear)], searchText: searchText)
                    }
                }
            
            List {
                if viewModel.loading {
                    HStack {
                        Spacer()
                        ProgressView("Loading...")
                        Spacer()
                    }
                } else {
                    if viewModel.bookList.isEmpty {
                        HStack {
                            Spacer()
                            Text("No Data avaialbale")
                            Spacer()
                        }
                    } else {
                        ForEach(viewModel.bookList) { book in
                            NavigationLink(destination: BookDetailView(book: book)) {
                                BookListCellView(book: book)
                            }
                        }
                    }
                    
                }
            }
            .navigationTitle("Book Shelf")
        }
    }
}
