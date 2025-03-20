//
//  SignUpView.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 17/03/25.
//

import Foundation
import SwiftUI


struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    @State var country: String = ""
    
    @State private var isValidEmail = false
    @State private var isValidPassword = false
    @State private var isValidName = false
    @State private var isValidCountry = false
    @State private var allFieldsValid: Bool = false
    
    @StateObject private var viewModel = SignUpViewModel()
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var navigateToHomePage = false
    
    var body: some View {
        VStack {
            EmailEntryView(email: $email, isValidEmail: $isValidEmail)
                .onChange(of: isValidEmail) { _, _ in allFieldsVaild() }
            PasswordEntryView(password: $password, isValidPassword: $isValidPassword, validationRequired: true)
                .onChange(of: isValidPassword) { _, _ in allFieldsVaild() }
            NameEntryView(name: $name, isValidName: $isValidName)
                .onChange(of: isValidName) { _, _ in allFieldsVaild() }
            CountryView(country: $country, isValidCountry: $isValidCountry)
                .onChange(of: isValidCountry) { _, _ in allFieldsVaild() }
            
            
            Button("Submit") {
                viewModel.signUpCompletion = { success, error in
                    if success {
                        navigateToHomePage = true
                    } else {
                        showAlert = true
                        alertMessage = "Signup failed!\n\(error?.localizedDescription ?? "Unknown error")"
                    }
                }
                Task {
                    await viewModel.createUserAndLogin(User(name: name, email: email, password: password, country: country))
                }
            }
            .disabled(!allFieldsValid)
            .foregroundColor(
                allFieldsValid ? Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)) : Color(#colorLiteral(red: 0.6533104777, green: 0.6533104777, blue: 0.6533104777, alpha: 1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        allFieldsValid ? Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)) : Color(#colorLiteral(red: 0.6533104777, green: 0.6533104777, blue: 0.6533104777, alpha: 1)),
                        lineWidth: 0.5)
                    .frame(width: 0.8*UIScreen.main.bounds.width, height: 50)
            )
            .frame(width: 0.8*UIScreen.main.bounds.width, height: 50) // Line thickness
            .background(Color.white)
            .font(.title3)
            
            .padding(.top, 20)
            
            if viewModel.processing {
                ProgressView()
            }
            
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Sign Up"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .navigationDestination(isPresented: $navigateToHomePage) {
            HomeView()
        }
    }
    
    private func allFieldsVaild() {
        allFieldsValid = isValidName && isValidEmail && isValidPassword && isValidCountry
    }
}
