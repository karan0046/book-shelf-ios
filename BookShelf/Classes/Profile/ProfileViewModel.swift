//
//  ProfileViewModel.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var logoutSuccess: Bool = false
    
    init() {
        
    }
    
    func logOut() async {
        await Table.CurrentUser.deleteAll(filters: nil) { success, error in
            guard success else {
                print(error as Any)
                return
            }
            CurrentUser.shared.profile = nil
        }
        logoutSuccess = true
    }
    
    deinit {
        print("ProfileViewModel deallocated")
    }
}
