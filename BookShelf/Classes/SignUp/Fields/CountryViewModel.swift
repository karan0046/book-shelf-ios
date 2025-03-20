//
//  CountryViewModel.swift
//  BookShelf
//
//  Created by Karan Kumar Sah on 18/03/25.
//

import SwiftUI

@MainActor
class CountryViewModel: ObservableObject {
    @Published var countries = [Country]()
    @Published var loading: Bool = false
    @Published var currentIPcountry: String = ""
    
    init() {
        Task {
            await fetchIPCountry()
            await fetchData()
        }
    }
    
    private func fetchData() async {
        loading = true
        guard let url = URL(string: "https://api.first.org/data/v1/countries") else {
            loading = false
            print("invalid url")
            return
        }
        let data = await APIService.shared.executeAPI(url: url)
        loading = false
        guard let result = data as? [String: Any], let countriesData = result["data"] as? [String: Any] else {
            return
        }
        countriesData.forEach { (key, value) in
            guard let countryDetails = value as? [String: Any], let name = countryDetails["country"] as? String, let region = countryDetails["region"] as? String else { return }
            self.countries.append(Country(isoCode: key, country: name, region: region))
        }
    }
    
    private func fetchIPCountry() async {
        loading = true
        guard let url = URL(string: "http://ip-api.com/json") else {
            loading = false
            print("invalid url")
            return
        }
        let data = await APIService.shared.executeAPI(url: url)
        loading = false
        guard let result = data as? [String: Any], let name = result["country"] as? String else { return }
        currentIPcountry = name
    }
    
    deinit {
        print("CountryViewModel deallocated")
    }
}
