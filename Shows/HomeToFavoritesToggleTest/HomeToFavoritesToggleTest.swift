//
//  HomeToDetailsTest.swift
//  HomeToDetailsTest
//
//  Created by Matej Kuprešak on 06.02.2024..
//

import XCTest

class HomeToFavortiesToggleTest: XCTestCase {

    func testNavigationToFavoritesAndTogglingFavorites() throws {
        let app = XCUIApplication()
        app.launch()
        
        let tabBar = app.tabBars.element
        tabBar.buttons["Favorites"].tap()
        
        // Wait for some time for the view transition
        sleep(2)
        
        // Count the number of elements in Favorites
        let favoritesElements = app.buttons.matching(identifier: "FavoriteViewElement")
        let initialFavoritesCount = favoritesElements.count
        
        // Go back to the Home screen
        tabBar.buttons["Home"].tap()
        
        // Wait for some time for the view transition
        sleep(2)
        
        let firstShowElement = app.buttons.matching(identifier: "HomeShowElement").firstMatch
        XCTAssertTrue(firstShowElement.exists, "First show element exists")

        let favoriteButton = firstShowElement.buttons["FavoriteButton"]
        XCTAssertTrue(favoriteButton.exists, "Favorite button exists")
        favoriteButton.tap()
        
        sleep(2)
        
        tabBar.buttons["Favorites"].tap()

        let newFavoritesElements = app.buttons.matching(identifier: "FavoriteViewElement")
        let newFavoritesCount = favoritesElements.count
        
        XCTAssertGreaterThan(newFavoritesCount, initialFavoritesCount)
        
        sleep(2)
    }
}
