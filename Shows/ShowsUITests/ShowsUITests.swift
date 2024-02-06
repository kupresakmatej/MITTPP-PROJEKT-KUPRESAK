//
//  ShowsUITests.swift
//  ShowsUITests
//
//  Created by Matej Kuprešak on 03.02.2024..
//
import XCTest

class SearchViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testSearchFunctionality() throws {
        sleep(2)
        
        // Access the tab bar
        let tabBar = app.tabBars.element

        // Navigate to the search tab
        tabBar.buttons["Search"].tap()

        // Access the search bar
        let searchBar = app.textFields["SearchBar"]

        // Wait for the search bar to exist
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: searchBar, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        // Check if the search bar is accessible
        XCTAssertTrue(searchBar.exists, "Search bar exists")
        
        // Tap the search bar to ensure it gains focus
        searchBar.tap()
        
        // Add a slight delay before typing (optional)
        sleep(2)

        // Enter a search query
        searchBar.typeText("drama")
        
        sleep(2)

        // Ensure that the search text matches the entered query
        XCTAssertEqual(searchBar.value as? String, "drama", "Search text matches entered query")

        // Wait for the search results to load
        let searchResults = app.buttons.matching(identifier: "SearchElement")

        // Check if the search results count is greater than 0
        XCTAssertTrue(searchResults.count > 0, "Search results count is greater than 0")
    }
}
