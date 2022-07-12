//
//  VehicleMakesDataTests.swift
//  MyFavoriteMakesTests
//
//  Created by Emilio Genesio on 12/07/22.
//

import XCTest
import Resolver
@testable import MyFavoriteMakes

#warning("Add comments to tests methods")
class VehicleMakesDataTests: UtilXCTestCase {
    
    lazy var dataOrigin = VehicleMakesDataOriginTest()
    lazy var favoritesDataOrigin = VehicleMakesFavoritesDataOriginTest()
    
    func test_getVehicleMakes() async throws {
        Self.registerDataOrigin(dataOrigin)
        Self.registerFavoritesDataOrigin(favoritesDataOrigin)
        
        let dataStoreMakes = try await dataStore.getMakes()
        let originItems = VehicleMakesDataOriginTest.makes
        
        XCTAssertEqual(dataStoreMakes.count, originItems.count)
        
        for (index, item) in dataStoreMakes.enumerated() {
            
            let originItem = originItems[index]
            
            XCTAssertEqual(item.slug, originItem.slug)
            XCTAssertEqual(item.name, originItem.name)
        }
    }
    
    func test_getVehicleMakesUnavailable() async {
        Self.registerDataOrigin(VehicleMakesDataOriginTestFailed())
        Self.registerFavoritesDataOrigin(favoritesDataOrigin)
        
        do {
            _ = try await dataStore.getMakes()
            XCTFail("The data store did not throw the error")
        } catch MFMError.unavailable {
            // do nothing, success path
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_getFavorites() async throws {
        Self.registerDataOrigin(dataOrigin)
        Self.registerFavoritesDataOrigin(favoritesDataOrigin)
        
        let dataStoreMakes = try await dataStore.getMakes().filter { $0.isFavorite }
        let originItems = favoritesDataOrigin.currentFavorites
        
        XCTAssertEqual(dataStoreMakes.count, originItems.count)
        
        for item in dataStoreMakes {
            XCTAssert(originItems.contains(item.slug))
        }
    }
    
    func test_getFavoritesUnavailable() async {
        Self.registerDataOrigin(dataOrigin)
        Self.registerFavoritesDataOrigin(VehicleMakesFavoritesDataOriginTestFailed())
        
        do {
            _ = try await dataStore.getMakes()
            XCTFail("The data store did not throw the error")
        } catch MFMError.unavailable {
            // do nothing, success path
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
}
