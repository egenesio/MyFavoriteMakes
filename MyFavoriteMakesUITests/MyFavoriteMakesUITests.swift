//
//  MyFavoriteMakesUITests.swift
//  MyFavoriteMakesUITests
//
//  Created by Emilio Genesio on 11/07/22.
//

import XCTest

class MyFavoriteMakesUITests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
    }
    
    // MARK: - Test cases
    
    /// Test case for the complete app flow.
    /// We test here:
    /// - That the favorites' count match the dataStore data at init
    /// - That the favorites' count match the dataStore when navigating back from the list
    /// - That adding and removing items from the favorites works as expected
    func test_completeAppFlow() throws {
        let app = XCUIApplication()
        app.launchArguments.append("-UITESTREGULAR")
        app.launch()
        
        let favoriteMakesCountText = existingElement(app.staticTexts["favoriteMakesCountText"])
        let seeAllVehicleMakesButton = existingElement(app.buttons["seeAllVehicleMakesButton"])
        
        assertFavoritesCount(element: favoriteMakesCountText, count: 2)
        
        // navigate to makes list view
        seeAllVehicleMakesButton.tap()
        
        let vehicleMakesListView = existingElement(app.scrollViews["vehicleMakesListView"])
        let navBarBackButton = existingElement(app.navigationBars.firstMatch.buttons.firstMatch)
        
        let alfaRomeoButton = existingElement(vehicleMakesListView.buttons["vehicleMakeItemView-alfa-romeo"])
        let audiButton = existingElement(vehicleMakesListView.buttons["vehicleMakeItemView-audi"])
        let toyotaButton = existingElement(vehicleMakesListView.buttons["vehicleMakeItemView-toyota"])

        assertVehicleMakeFavoriteStatus(element: alfaRomeoButton, isFavorite: false)
        assertVehicleMakeFavoriteStatus(element: audiButton, isFavorite: true)
        assertVehicleMakeFavoriteStatus(element: toyotaButton, isFavorite: true)
        
        alfaRomeoButton.tap()
        assertVehicleMakeFavoriteStatus(element: alfaRomeoButton, isFavorite: true)
        
        alfaRomeoButton.tap()
        assertVehicleMakeFavoriteStatus(element: alfaRomeoButton, isFavorite: false)
        
        audiButton.tap()
        assertVehicleMakeFavoriteStatus(element: audiButton, isFavorite: false)

        // go back to main view
        navBarBackButton.tap()
        
        assertFavoritesCount(element: favoriteMakesCountText, count: 1)
        
        // navigate to makes list view
        seeAllVehicleMakesButton.tap()
        
        alfaRomeoButton.tap()
        assertVehicleMakeFavoriteStatus(element: alfaRomeoButton, isFavorite: true)
        
        audiButton.tap()
        assertVehicleMakeFavoriteStatus(element: audiButton, isFavorite: true)
        
        toyotaButton.tap()
        assertVehicleMakeFavoriteStatus(element: toyotaButton, isFavorite: false)

        // go back to main view
        navBarBackButton.tap()
        
        assertFavoritesCount(element: favoriteMakesCountText, count: 2)
    }
    
    /// Test case for the error flow.
    /// We test here:
    /// - That the error view is displayed.
    /// - That we can retry loading the data and that the count view is displayed.
    func test_errorFlow() throws {
        let app = XCUIApplication()
        app.launchArguments.append("-UITESTERROR")
        app.launch()
        
        let retryButton = existingElement(app.buttons["retryButton"])
        retryButton.tap()
        
        _ = existingElement(app.staticTexts["favoriteMakesCountText"])
        _ = existingElement(app.buttons["seeAllVehicleMakesButton"])
    }
    
    // MARK: - Utils methods
    
    /// Runs a `XCTAssertEqual` on the element's label property against the count as `String`
    /// - Parameters:
    ///   - element: the count `XCUIElement`
    ///   - count: the actual `Int` count
    private func assertFavoritesCount(element: XCUIElement, count: Int) {
        XCTAssertEqual(element.label, "\(count)")
    }
    
    /// Runs a `XCTAssertEqual` on the element's label property against the `isFavorite` status.
    /// - Parameters:
    ///   - element: the button image `XCUIElement`
    ///   - isFavorite: if the item to compare is favorite or not
    private func assertVehicleMakeFavoriteStatus(element: XCUIElement, isFavorite: Bool) {
        XCTAssertEqual(element.label, isFavorite ? "heart.fill" : "heart")
    }
    
    /// Runs a `XCTAssert` for the given element and return it if exists.
    /// - Parameter elementGetter: query that represents the `XCUIElement` to assert and return.
    /// - Returns: The given `XCUIElement`
    private func existingElement(_ elementGetter: @autoclosure () -> XCUIElement) -> XCUIElement {
        let element = elementGetter()
        XCTAssert(element.exists)
        return element
    }
}
