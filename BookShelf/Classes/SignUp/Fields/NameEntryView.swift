//
//  NameEntryView.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 17/03/25.
//

import Foundation
import SwiftUI

struct NameEntryView: View {
    @Binding var name: String
    @Binding var isValidName: Bool
    
    var body: some View {
        VStack {
            Text("Name")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(
                    Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                )
                .padding(.top, 20)
                .padding(.leading, 20)
                .font(.title2)
            
            TextField("Enter your name", text: $name)
                .onChange(of: name, { oldValue, newValue in
                    isValidName = isValidName(newValue)
                })
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
        }
    }
    
    func isValidName(_ name: String) -> Bool {
        return !name.isEmpty
    }
}
