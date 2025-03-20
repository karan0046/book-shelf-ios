//
//  BookYearViewModel.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

class BookYearViewModel: ObservableObject {
    var years = [String]()
    
    init() {
        years = (2005...2014).map { String($0) }.reversed()
    }
    
    deinit {
        print("BookYearViewModel deallocated")
    }
}
