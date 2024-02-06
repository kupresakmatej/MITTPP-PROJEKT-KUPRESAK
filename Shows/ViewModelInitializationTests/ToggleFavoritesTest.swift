//
//  ToggleFavoritesTest.swift
//  ViewModelInitializationTests
//
//  Created by Matej Kuprešak on 03.02.2024..
//

import XCTest

final class ToggleFavoritesTest: XCTestCase {
    let mockShow = Show(id: 1, url: "", name: "", language: "", genres: [], premiered: "", image: [:], rating: Rating(average: 1), airtime: "", summary: "")
    
    func testDetailsViewModelToggleFavorites() {
        let favoriteService = MockFavoritesService()
        let viewModel = DetailsViewModel(show: mockShow, favoriteService: favoriteService)
        viewModel.toggleFavorites()
        XCTAssertTrue(viewModel.isFavorite)
    }
}
