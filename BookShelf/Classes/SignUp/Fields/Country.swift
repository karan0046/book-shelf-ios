//
//  Country.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

struct Country: Hashable {
    var isoCode: String
    var country: String
    var region: String
    
    init(isoCode: String, country: String, region: String) {
        self.isoCode = isoCode
        self.country = country
        self.region = region
    }
}
