//
//  VehicleMakesFavoritesDataOriginTestFailed.swift
//  MyFavoriteMakesTests
//
//  Created by Emilio Genesio on 12/07/22.
//

import Foundation
@testable import MyFavoriteMakes

class VehicleMakesFavoritesDataOriginTestFailed: VehicleMakesFavoritesDataOrigin {
    
    func getFavoritesSlugs() async throws -> Set<String> {
        throw MFMError.unavailable
    }
    
    func addMakeToFavorites(slug: String) async throws {
        throw MFMError.unavailable
    }
    
    func removeMakeFromFavories(slug: String) async throws {
        throw MFMError.unavailable
    }
    
    
}
