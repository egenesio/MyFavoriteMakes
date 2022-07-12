//
//  VehicleMakesFavoritesDataOriginMock.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 12/07/22.
//

import Foundation

class VehicleMakesFavoritesDataOriginMock: VehicleMakesFavoritesDataOrigin {
    
    private var favorites = Set<String>(arrayLiteral: "audi", "toyota")
    
    func getFavoritesSlugs() async throws -> Set<String> {
        return favorites
    }
    
    func addMakeToFavorites(slug: String) async throws {
        sleep(UInt32.random(in: 0...1))
        favorites.insert(slug)
    }
    
    func removeMakeFromFavories(slug: String) async throws {
        sleep(UInt32.random(in: 0...1))
        guard let _ = favorites.remove(slug) else {
            throw MFMError.notFound
        }
    }
    
}
