//
//  VehicleMakesFavoritesDataOriginTestFailedOperations.swift
//  MyFavoriteMakesTests
//
//  Created by Emilio Genesio on 12/07/22.
//

import Foundation
@testable import MyFavoriteMakes

class VehicleMakesFavoritesDataOriginTestFailedOperations: VehicleMakesFavoritesDataOrigin {
    
    static var favorites = Set(arrayLiteral: "make1")
    
    lazy var currentFavorites = Self.favorites
    
    func getFavoritesSlugs() async throws -> Set<String> {
        currentFavorites
    }
    
    func addMakeToFavorites(slug: String) async throws {
        throw MFMError.unavailable
    }
    
    func removeMakeFromFavories(slug: String) async throws {
        throw MFMError.unavailable
    }
}
