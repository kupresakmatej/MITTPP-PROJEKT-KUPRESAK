//
//  ViewModelInitializationTests.swift
//  ViewModelInitializationTests
//
//  Created by Matej Kuprešak on 02.02.2024..
//
import XCTest

class ViewModelInitializationTests: XCTestCase {
    let mockShow = Show(id: 1, url: "", name: "", language: "", genres: [], premiered: "", image: [:], rating: Rating(average: 1), airtime: "", summary: "")

    func testHomeViewModelInitialization() {
        let viewModel = HomeViewModel(favoriteService: MockFavoritesService())
        XCTAssertNotNil(viewModel)
    }

    func testSearchViewModelInitialization() {
        let viewModel = SearchViewModel()
        XCTAssertNotNil(viewModel)
    }

    func testFavoritesViewModelInitialization() {
        let viewModel = FavoritesViewModel(favoriteService: MockFavoritesService())
        XCTAssertNotNil(viewModel)
    }

    func testDetailsViewModelInitialization() {
        let viewModel = DetailsViewModel(show: mockShow, favoriteService: MockFavoritesService())
        XCTAssertNotNil(viewModel)
    }
}
