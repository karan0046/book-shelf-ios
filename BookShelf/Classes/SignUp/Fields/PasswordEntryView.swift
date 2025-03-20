//
//  PasswordEntryView.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 17/03/25.
//

import Foundation
import SwiftUI

struct PasswordEntryView: View {
    @Binding var password: String
    @Binding var isValidPassword: Bool
    var validationRequired: Bool
    
    @State private var isPasswordVisible = false
    
    
    var body: some View {
        VStack {
            Text("Password")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(
                    Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                )
                .padding(.leading, 20)
                .font(.title2)
            
            HStack {
                if isPasswordVisible {
                    TextField("Enter your password", text: $password)
                        .onChange(of: password) { oldValue, newValue in
                            guard validationRequired else { return }
                            isValidPassword = validatePassword(newValue).isValid
                        }
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                } else {
                    SecureField("Enter your password", text: $password)
                        .onChange(of: password) { oldValue, newValue in
                            guard validationRequired else { return }
                            isValidPassword = validatePassword(newValue).isValid
                        }
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        
                }
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                        .foregroundColor(.gray)
                }
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .overlay(
                Rectangle()
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .frame(maxWidth: .infinity, maxHeight: 2) // Line thickness
                    .foregroundColor(
                        Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                    ), // Line color
                alignment: .bottom
            )
            
            if validationRequired {
                VStack(alignment: .leading, spacing: 6) {
                    let validationResult = validatePassword(password)
                    RequirementRow(label: "Uppercase letter", isMet: validationResult.hasUppercase)
                    RequirementRow(label: "Lowercase letter", isMet: validationResult.hasLowercase)
                    RequirementRow(label: "Number", isMet: validationResult.hasNumber)
                    RequirementRow(label: "Special character [!@#$%&()]", isMet: validationResult.hasSpecialCharacter)
                    RequirementRow(label: "Minimum 8 characters", isMet: validationResult.isMinLength)
                }
                .padding()
            }
        }
    }
    
    func validatePassword(_ password: String) -> PasswordValidationResult {
        return PasswordValidationResult(
            hasUppercase: password.range(of: "[A-Z]", options: .regularExpression) != nil,
            hasLowercase: password.range(of: "[a-z]", options: .regularExpression) != nil,
            hasNumber: password.range(of: "\\d", options: .regularExpression) != nil,
            hasSpecialCharacter: password.range(of: "[\\W_]", options: .regularExpression) != nil,
            isMinLength: password.count >= 8
        )
    }
}

struct PasswordValidationResult {
    var hasUppercase: Bool
    var hasLowercase: Bool
    var hasNumber: Bool
    var hasSpecialCharacter: Bool
    var isMinLength: Bool
    
    var isValid: Bool {
        hasUppercase && hasLowercase && hasNumber && hasSpecialCharacter && isMinLength
    }
}

struct RequirementRow: View {
    let label: String
    let isMet: Bool

    var body: some View {
        HStack {
            Image(systemName: isMet ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(isMet ? .green : .red)
            Text(label)
                .foregroundColor(isMet ? .green : .red)
        }
    }
}
