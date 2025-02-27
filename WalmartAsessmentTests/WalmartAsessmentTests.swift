//
//  WalmartAsessmentTests.swift
//  WalmartAsessmentTests
//
//  Created by David Mottle on 2/26/25.
//


import XCTest
@testable import WalmartAsessment

final class WalmartAsessmentTests: XCTestCase {
    var viewModel: CountryViewModel!
    var mockAPI: MockAPIClient!
    var viewController: CountryViewController!
    var apiClient : APIClientProtocol!
    
    override func setUp() {
        super.setUp()
        mockAPI = MockAPIClient()
        viewModel = CountryViewModel(apiClient: mockAPI)
        viewController = CountryViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPI = nil
        viewController = nil
        super.tearDown()
    }
    
    func testNumberOfCountries() async {
        await viewModel.fetchCountryData()
        XCTAssertEqual(viewModel.numberOfCountries(), 2)
    }
    
    func testCountryAt() async {
        await viewModel.fetchCountryData()
        let countryFirst = viewModel.country(at: 1)
        XCTAssertEqual(countryFirst.name, "American Samoa")
        XCTAssertEqual(countryFirst.capital, "Pago Pago")
    }
    func testFileterCountryWithValidQuery() async {
        await viewModel.fetchCountryData()
        viewModel.filterCountries(for: "Algeria")
        XCTAssertEqual(viewModel.numberOfCountries(), 1)
    }
    
    func testFileterCountryWithInValidQuery() async {
        await viewModel.fetchCountryData()
        viewModel.filterCountries(for: "UnKnown")
        XCTAssertEqual(viewModel.numberOfCountries(), 0)
    }
    
    func testFileterCountryWithEmptyQuery() async {
        await viewModel.fetchCountryData()
        viewModel.filterCountries(for: "")
        XCTAssertEqual(viewModel.numberOfCountries(), 2)
    }

    
}
