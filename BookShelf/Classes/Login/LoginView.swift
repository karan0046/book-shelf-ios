//
//  LoginView.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 17/03/25.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @State private var isValidEmail = false
    @State private var isValidPassword = false
    @State private var allFieldsValid: Bool = false
    
    @StateObject var viewModel = LoginViewModel()
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var navigateToHomePage = false
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                EmailEntryView(email: $email, isValidEmail: $isValidEmail)
                    .onChange(of: isValidEmail) { _, _ in allFieldsVaild() }
                PasswordEntryView(password: $password, isValidPassword: $isValidPassword, validationRequired: false)
                    .onChange(of: password) { _, _ in allFieldsVaild() }
            }
            
            Button("Submit") {
                Task {
                    await viewModel.checkValidCreds(email, password)
                    if viewModel.validCreds {
                        navigateToHomePage = true
                    } else {
                        showAlert = true
                        alertMessage = "Credentials are not Valid \n Please enter correct details"
                    }
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        allFieldsValid ? Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)) : Color(#colorLiteral(red: 0.6533104777, green: 0.6533104777, blue: 0.6533104777, alpha: 1)),
                        lineWidth: 0.5
                    )
                    .frame(width: 0.8*UIScreen.main.bounds.width, height: 50)
            )
            .disabled(!allFieldsValid)
            .frame(width: 0.8*UIScreen.main.bounds.width, height: 50) // Line thickness
            .background(Color.white)
            .font(.title3)
            .foregroundColor(
                allFieldsValid ? Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)) : Color(#colorLiteral(red: 0.6533104777, green: 0.6533104777, blue: 0.6533104777, alpha: 1))
            )
            .padding(.top, 30)
            
            if viewModel.processing {
                ProgressView()
            } else {
                
            }
            
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Login"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .navigationDestination(isPresented: $navigateToHomePage) {
            HomeView()
        }
        .background(Color.white)
    }
    
    private func allFieldsVaild()  {
        allFieldsValid = isValidEmail && !password.isEmpty
    }
}
