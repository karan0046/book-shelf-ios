//
//  Book.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import Foundation

struct Book: Identifiable {
    var id: String = UUID().uuidString
    let image: String
    let score: Double
    let popularity: Int
    let title: String
    let publishedChapterDate: TimeInterval
    let publishedChapterYear: String
    
    init(id: String, title: String, score: Double, publishedYear: String, image: String, popularity: Int, publishedChapterDate: TimeInterval) {
        self.id = id
        self.title = title
        self.score = score
        self.image = image
        self.popularity = popularity
        self.publishedChapterDate = publishedChapterDate
        self.publishedChapterYear = formatDate(from: publishedChapterDate, format: "yyyy")
    }
    
    init(book: Book) {
        self.id = book.id
        self.title = book.title
        self.score = book.score
        self.image = book.image
        self.popularity = book.popularity
        self.publishedChapterDate = book.publishedChapterDate
        self.publishedChapterYear = formatDate(from: publishedChapterDate, format: "yyyy")
    }
    
    init(json: [String: Any]) {
        self.id = json["id"] as? String ?? UUID().uuidString
        self.title = json["title"] as? String ?? "Unknown Title"
        self.score = json["score"] as? Double ?? 0.0
        self.image = json["image"] as? String ?? "defaultImage"
        self.popularity = json["popularity"] as? Int ?? 0
        self.publishedChapterDate = json["publishedChapterDate"] as? TimeInterval ?? 0
        self.publishedChapterYear = formatDate(from: publishedChapterDate, format: "yyyy")
    }
    
    func toDic() -> [String: Any] {
        [
            "id": id,
            "title": title,
            "score": score,
            "image": image,
            "popularity": popularity,
            "publishedChapterDate": publishedChapterDate,
            "publishedChapterYear": publishedChapterYear
        ]
    }
}
