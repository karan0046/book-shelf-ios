//
//  APIService.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import Foundation


class APIService {
    static let shared = APIService()
    
    private init() { }
    
    func executeAPI(url: URL) async -> Any? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONSerialization.jsonObject(with: data)
        } catch {
            print("Failed to executeAPI url-\(url), error-\(error)")
            return  nil
        }
    }
}

extension APIService: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
