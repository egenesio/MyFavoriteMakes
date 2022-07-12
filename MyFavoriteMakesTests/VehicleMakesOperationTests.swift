//
//  VehicleMakesOperationTests.swift
//  MyFavoriteMakesTests
//
//  Created by Emilio Genesio on 11/07/22.
//

import XCTest
@testable import MyFavoriteMakes

#warning("Add comments to tests methods")
class VehicleMakesOperationTests: UtilXCTestCase {
    
    lazy var dataOrigin = VehicleMakesDataOriginTest()
    lazy var favoritesDataOrigin = VehicleMakesFavoritesDataOriginTest()
    
    override func tearDown() async throws {
        favoritesDataOrigin.currentFavorites = VehicleMakesFavoritesDataOriginTest.favorites
    }
    
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
    
    func test_setVehicleMakeAsFavoriteInexistent() async throws {
        Self.registerDataOrigin(dataOrigin)
        Self.registerFavoritesDataOrigin(favoritesDataOrigin)
        
        try await dataStore.getMakes()
        let inexistant = VehicleMake(id: 0, slug: "non", name: "Non")
        
        do {
            try await dataStore.toggleFavoriteStatusForMake(inexistant)
            XCTFail("The data store did not throw the error")
        } catch MFMError.notFound {
            // do nothing, this is the success path
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_setVehicleMakeAsFavoriteUnavailable() async throws {
        Self.registerDataOrigin(dataOrigin)
        Self.registerFavoritesDataOrigin(VehicleMakesFavoritesDataOriginTestFailedOperations())
        
        let makes = try await dataStore.getMakes()
        let nonFavoriteItem = try XCTUnwrap(
            makes.first { !$0.isFavorite }
        )
        
        do {
            try await dataStore.toggleFavoriteStatusForMake(nonFavoriteItem)
            XCTFail("The data store did not throw the error")
        } catch MFMError.unavailable {
            // do nothing, this is the success path
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
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
    
    func test_unsetVehicleMakeAsFavoriteInexistent() async throws {
        Self.registerDataOrigin(dataOrigin)
        Self.registerFavoritesDataOrigin(favoritesDataOrigin)
        
        try await dataStore.getMakes()
        let inexistant = VehicleMake(id: 0, slug: "non", name: "Non", isFavorite: true)
        
        do {
            try await dataStore.toggleFavoriteStatusForMake(inexistant)
            XCTFail("The data store did not throw the error")
        } catch MFMError.notFound {
            // do nothing, this is the success path
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_unsetVehicleMakeAsFavoriteUnavailable() async throws {
        Self.registerDataOrigin(dataOrigin)
        Self.registerFavoritesDataOrigin(VehicleMakesFavoritesDataOriginTestFailedOperations())
        
        let favorites = try await dataStore.getMakes().favorites
        let favoriteItem = try XCTUnwrap(favorites.first)
        
        do {
            try await dataStore.toggleFavoriteStatusForMake(favoriteItem)
            XCTFail("The data store did not throw the error")
        } catch MFMError.unavailable {
            // do nothing, this is the success path
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
}
