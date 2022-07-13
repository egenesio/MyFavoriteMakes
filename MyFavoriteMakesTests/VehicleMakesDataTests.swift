//
//  VehicleMakesDataTests.swift
//  MyFavoriteMakesTests
//
//  Created by Emilio Genesio on 12/07/22.
//

import XCTest
import Resolver
@testable import MyFavoriteMakes

class VehicleMakesDataTests: UtilXCTestCase {
    
    // MARK: - Properties
    
    lazy var dataOrigin = VehicleMakesDataOriginTest()
    lazy var favoritesDataOrigin = VehicleMakesFavoritesDataOriginTest()
    
    // MARK: - Test cases
    
    /// Test case for getting the vehicle makes
    /// We test here:
    /// - The regular path.
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
    
    /// Test case for getting the vehicle makes from an unavailable data origin
    /// We test here:
    /// - The error path
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
    
    /// Test case for getting the favorite vehicle makes
    /// We test here:
    /// - The regular path
    func test_getFavorites() async throws {
        Self.registerDataOrigin(dataOrigin)
        Self.registerFavoritesDataOrigin(favoritesDataOrigin)
        
        let dataStoreMakes = try await dataStore.getMakes().favorites
        let originItems = favoritesDataOrigin.currentFavorites
        
        XCTAssertEqual(dataStoreMakes.count, originItems.count)
        
        for item in dataStoreMakes {
            XCTAssert(originItems.contains(item.slug))
        }
    }
    
    /// Test case for getting the favorites vehicle makes from an unavailable favorites data origin
    /// We test here:
    /// - The error path
    func test_getFavoritesUnavailable() async {
        Self.registerDataOrigin(dataOrigin)
        Self.registerFavoritesDataOrigin(VehicleMakesFavoritesDataOriginTestFailed())
        
        do {
            _ = try await dataStore.getMakes().favorites
            XCTFail("The data store did not throw the error")
        } catch MFMError.unavailable {
            // do nothing, success path
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
}
