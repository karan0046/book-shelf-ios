//
//  EmailEntryView.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 17/03/25.
//

import Foundation
import SwiftUI

struct EmailEntryView: View {
    @Binding var email: String
    @Binding var isValidEmail: Bool
    
    var body: some View {
        VStack {
            Text("Email ID")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(
                    Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                )
                .padding(.top, 20)
                .padding(.leading, 20)
                .font(.title2)
            
            TextField("Enter your email", text: $email)
                .onChange(of: email) { oldValue, newValue in
                    isValidEmail = isValidEmailFormat(newValue)
                }
                .overlay(
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 2) // Line thickness
                        .foregroundColor(
                            Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                        ), // Line color
                    alignment: .bottom
                )
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
            
            if !email.isEmpty {
                Text(isValidEmail ? "" : "Invalid email format")
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
    
    private func isValidEmailFormat(_ email: String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailRegex = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES[c] %@", emailRegex).evaluate(with: email)
    }
}
