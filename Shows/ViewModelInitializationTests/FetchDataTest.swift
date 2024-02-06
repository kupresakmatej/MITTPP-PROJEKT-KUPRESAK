//
//  FetchDataTest.swift
//  ViewModelInitializationTests
//
//  Created by Matej Kuprešak on 02.02.2024..
//

import XCTest

class FetchDataTests: XCTestCase {
    let networkingService = NetworkingService()
    let favoritesService = FavoriteService(persistenceService: PersistenceService())
    
    func testHomeViewModelFetchShows() {
        let viewModel = HomeViewModel(favoriteService: favoritesService)
        let expectation = XCTestExpectation(description: "Fetch Shows")
        
        viewModel.fetchShows(numberOfShows: 5)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            XCTAssertEqual(viewModel.shows.count, 5)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSearchViewModelFetchData() {
        let viewModel = SearchViewModel()
        let expectation = XCTestExpectation(description: "Fetch Data")
        
        viewModel.fetchData(query: "drama")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            XCTAssertGreaterThan(viewModel.shows.count, 0, "Search results should not be empty")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
