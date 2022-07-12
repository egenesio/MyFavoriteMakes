//
//  VehicleMakesFavoritesDataOriginTest.swift
//  MyFavoriteMakesTests
//
//  Created by Emilio Genesio on 12/07/22.
//

import Foundation
@testable import MyFavoriteMakes

class VehicleMakesFavoritesDataOriginTest: VehicleMakesFavoritesDataOrigin {
    
    static var favorites = Set(arrayLiteral: "make1")
    
    lazy var currentFavorites = Self.favorites
    
    func getFavoritesSlugs() async throws -> Set<String> {
        currentFavorites
    }
    
    func addMakeToFavorites(slug: String) async throws {
        currentFavorites.insert(slug)
    }
    
    func removeMakeFromFavories(slug: String) async throws {
        guard let _ = currentFavorites.remove(slug) else {
            throw MFMError.notFound
        }
    }
}
