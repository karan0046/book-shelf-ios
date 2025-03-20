//
//  BookYearView.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

struct BookYearView: View {
    @StateObject var viewModel = BookYearViewModel()
    @Binding var selectedYear: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 16) {
                ForEach(viewModel.years, id: \.self) { year in
                    Text(year)
                        .font(.headline)
                        .foregroundColor(year == selectedYear ? Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)) : .gray)
                        .underline(year == selectedYear, color: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                        .onTapGesture {
                            selectedYear = year
                        }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            .onAppear {
                if let maxYear = viewModel.years.max() {
                    selectedYear = maxYear
                }
            }
        }
    }
}
