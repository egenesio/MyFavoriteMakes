//
//  VehicleMakesOperationTests.swift
//  MyFavoriteMakesTests
//
//  Created by Emilio Genesio on 11/07/22.
//

import XCTest
@testable import MyFavoriteMakes

class VehicleMakesOperationTests: UtilXCTestCase {
    
    override func tearDown() async throws {
        favoritesDataOrigin.currentFavorites = VehicleMakesFavoritesDataOriginTest.favorites
    }
    
    // MARK: - Properties
    
    lazy var dataOrigin = VehicleMakesDataOriginTest()
    lazy var favoritesDataOrigin = VehicleMakesFavoritesDataOriginTest()
    
    // MARK: - Test cases
    
    /// Test case for setting a vehicle make as favorite
    /// We test here:
    /// - That a non favorite make is marked as favorite after calling the method
    func test_setVehicleMakeAsFavorite() async throws {
        Self.registerDataOrigin(dataOrigin)
        Self.registerFavoritesDataOrigin(favoritesDataOrigin)
        
        let makes = try await dataStore.getMakes()
        let nonFavoriteItem = try XCTUnwrap(
            makes.first { !$0.isFavorite }
        )
        
        XCTAssertFalse(
            makes.favorites.contains { $0.slug == nonFavoriteItem.slug }
        )
        
        try await dataStore.toggleFavoriteStatusForMake(nonFavoriteItem)
        
        XCTAssert(
            dataStore.vehicleMakes.value.favorites.contains { $0.slug == nonFavoriteItem.slug }
        )
    }
    
    /// Test case for setting a non existent vehicle make as favorite
    /// We test here:
    /// - That a non existent make cannot be marked as favorite after calling the method
    /// - That the correct error is catched
    func test_setVehicleMakeAsFavoriteInexistent() async throws {
        Self.registerDataOrigin(dataOrigin)
        Self.registerFavoritesDataOrigin(favoritesDataOrigin)
        
        try await dataStore.getMakes()
        let inexistant = VehicleMake(id: 0, slug: "non", name: "Non")
        
        do {
            try await dataStore.toggleFavoriteStatusForMake(inexistant)
            XCTFail("The data store did not throw an error")
        } catch MFMError.notFound {
            // do nothing, this is the success path
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    /// Test case for setting a non favorite vehicle make as favorite when the data origin is not available
    /// We test here:
    /// - That a non favorite make cannot be marked as favorite after calling the method
    /// - That the correct error is catched
    func test_setVehicleMakeAsFavoriteUnavailable() async throws {
        Self.registerDataOrigin(dataOrigin)
        Self.registerFavoritesDataOrigin(VehicleMakesFavoritesDataOriginTestFailedOperations())
        
        let makes = try await dataStore.getMakes()
        let nonFavoriteItem = try XCTUnwrap(
            makes.first { !$0.isFavorite }
        )
        
        do {
            try await dataStore.toggleFavoriteStatusForMake(nonFavoriteItem)
            XCTFail("The data store did not throw an error")
        } catch MFMError.unavailable {
            // do nothing, this is the success path
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    /// Test case for unsetting a vehicle make as favorite
    /// We test here:
    /// - That a favorite make is not marked as favorite after calling the method
    func test_unsetVehicleMakeAsFavorite() async throws {
        Self.registerDataOrigin(dataOrigin)
        Self.registerFavoritesDataOrigin(favoritesDataOrigin)
        
        let favorites = try await dataStore.getMakes().favorites
        let favoriteItem = try XCTUnwrap(favorites.first)
            
        try await dataStore.toggleFavoriteStatusForMake(favoriteItem)
                    
        XCTAssertFalse(
            dataStore.vehicleMakes.value.favorites.contains { $0.slug == favoriteItem.slug }
        )
    }
    
    /// Test case for unsetting a non existent vehicle make as favorite
    /// We test here:
    /// - That a non existent make cannot be marked as non favorite after calling the method
    /// - That the correct error is catched
    func test_unsetVehicleMakeAsFavoriteInexistent() async throws {
        Self.registerDataOrigin(dataOrigin)
        Self.registerFavoritesDataOrigin(favoritesDataOrigin)
        
        _ = try await dataStore.getMakes()
        let inexistant = VehicleMake(id: 0, slug: "non", name: "Non", isFavorite: true)
        
        do {
            try await dataStore.toggleFavoriteStatusForMake(inexistant)
            XCTFail("The data store did not throw an error")
        } catch MFMError.notFound {
            // do nothing, this is the success path
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    /// Test case for unsetting a favorite vehicle make when the data origin is not available
    /// We test here:
    /// - That a favorite make cannot be unmarked as favorite after calling the method
    /// - That the correct error is catched
    func test_unsetVehicleMakeAsFavoriteUnavailable() async throws {
        Self.registerDataOrigin(dataOrigin)
        Self.registerFavoritesDataOrigin(VehicleMakesFavoritesDataOriginTestFailedOperations())
        
        let favorites = try await dataStore.getMakes().favorites
        let favoriteItem = try XCTUnwrap(favorites.first)
        
        do {
            try await dataStore.toggleFavoriteStatusForMake(favoriteItem)
            XCTFail("The data store did not throw an error")
        } catch MFMError.unavailable {
            // do nothing, this is the success path
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
}
