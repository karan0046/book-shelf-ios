//
//  ProfileView.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ProfileViewModel()
    @State private var navigateTolaunchScreen = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(
                    Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                )
                .frame(width: 180, height: 180)
                .padding(.bottom, 10)
            
            Text(CurrentUser.shared.profile?.name ?? "NA")
                .font(.title)
                .fontWeight(.semibold)
            
            Text(CurrentUser.shared.profile?.email ?? "Unknown email")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button("Logout") {
                Task {
                    await viewModel.logOut()
                }
            }
            Spacer()
        }
        .onChange(of: viewModel.logoutSuccess) { oldValue, newValue in
            guard newValue else { return }
            navigateTolaunchScreen = true
        }
        .navigationDestination(isPresented: $navigateTolaunchScreen) {
            LaunchScreenView()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .navigationTitle("Profile")
        
    }
}
