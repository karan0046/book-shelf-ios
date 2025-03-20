//
//  BookSummaryView.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

struct BookSummaryView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Summary")
                .font(.title2)
                .bold()
                .padding(.leading, 20)
            
            Text("""
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
                Nullam scelerisque quam non nibh aliquet, id fermentum erat viverra. 
                Vivamus ac sapien at nisi varius vehicula eget eget mauris.
                """)
            .font(.body)
            .foregroundColor(.gray)
            .padding(.bottom, 20)
            .padding(.leading, 20)
        }
    }
}
