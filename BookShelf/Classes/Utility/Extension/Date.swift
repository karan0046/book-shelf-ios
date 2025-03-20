//
//  Date.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import Foundation

func convertEpochToDate(epoch: TimeInterval) -> Date {
    return Date(timeIntervalSince1970: epoch)
}

func formatDate(from epoch: TimeInterval, format: String = "dd/MM/yyyy") -> String {
    let date = convertEpochToDate(epoch: epoch)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}
