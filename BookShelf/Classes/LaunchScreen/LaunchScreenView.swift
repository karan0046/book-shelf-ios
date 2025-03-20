//
//  LaunchScreenView.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

struct LaunchScreenView: View {
    @StateObject var viewModel = LaunchScreenViewModel()
    @State private var scaleEffect = 0.5
    @Environment(\.dismiss) var dismiss
    @State private var navigateToHome = false
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Image(systemName: "books.vertical")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 100)
                        .foregroundColor(
                            Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                        )
                        .scaleEffect(scaleEffect)
                        .onAppear {
                            withAnimation(.easeOut(duration: 1.5)) {
                                scaleEffect = 1.0
                            }
                            if viewModel.userLoggedIn {
                                navigateToHome = true
                            }
                        }
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .padding(.bottom, 40)
                
                if !viewModel.userLoggedIn {
                    NavigationLink(destination: SignUpView(), label: {
                        Text("Sign up with an E-mail")
                    })
                    .padding()
                    .frame(width: 0.7*UIScreen.main.bounds.width, height: 50)
                    .background(
                        Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                    )
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .font(.headline)
                    
                    
                    NavigationLink(destination: LoginView(), label: {
                        Text("Already a Memebr? Log in")
                    })
                    .padding()
                    .frame(width: 0.7*UIScreen.main.bounds.width, height: 50)
                    .foregroundColor(
                        Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                    )
                    .background(Color.white)
                    .cornerRadius(10)
                    .font(.headline)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                }
            }
            .onChange(of: viewModel.userLoggedIn, { oldValue, newValue in
                navigateToHome = newValue
            })
            .navigationDestination(isPresented: $navigateToHome) {
                HomeView()
            }
            .navigationBarBackButtonHidden()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
