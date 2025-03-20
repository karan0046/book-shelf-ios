//
//  BookShelfApp.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 17/03/25.
//

import SwiftUI

@main
struct BookShelfApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
        }
    }
}
