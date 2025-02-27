//
//  CountryViewModel.swift
//  WalmartAsessment
//
//  Created by David Mottle on 2/26/25.
//


import Foundation

//MARK: - CountryViewModel
class CountryViewModel: @unchecked Sendable {
    private var apiClient: APIClientProtocol
    private var allCountries: [Country] = []
    private var filteredCountries: [Country] = []
    
    var isFiltering: Bool = false
    var onDataUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchCountryData() async {
        do {
            let countries = try await apiClient.fetchData()
            allCountries = countries
            filteredCountries = countries
            DispatchQueue.main.async {
                self.onDataUpdate?()
            }
        } catch let error as APIError {
            DispatchQueue.main.async {
                self.onError?(self.errorMessage(for: error))
            }
        } catch {
            DispatchQueue.main.async {
                self.onError?("An unexpected error occurred.")
            }
        }
    }
    
    //MARK: - Helper Methods
    
    func numberOfCountries() -> Int {
        return isFiltering ? filteredCountries.count : allCountries.count
    }
    
    func country(at index: Int) -> Country {
        return isFiltering ? filteredCountries[index] : allCountries[index]
    }
    
    //MARK: - filterCountries
    
    func filterCountries(for searchText: String) {
        isFiltering = !searchText.isEmpty
        filteredCountries = allCountries.filter { country in
            country.name.lowercased().contains(searchText.lowercased()) ||
            country.capital.lowercased().contains(searchText.lowercased())
        }
        onDataUpdate?()
    }
    
    //MARK: - Error Handling
    
    private func errorMessage(for error: APIError) -> String {
        return error.description
    }

}

