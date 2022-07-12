//
//  VehicleMakesFavoritesDataOrigin.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 11/07/22.
//

import Foundation

protocol VehicleMakesFavoritesDataOrigin {
    
    /// Gets the favorites slugs from the current Origin
    ///
    /// - Returns: `Set<String>`
    func getFavoritesSlugs() async throws -> Set<String>
    
    /// Adds the `VehicleMake` slug to the current Origin
    ///
    /// - Parameter slug: the `VehicleMake` slug
    func addMakeToFavorites(slug: String) async throws
    
    /// Removes the `VehicleMake` slug from the current Origin
    ///
    /// - Parameter slug: the `VehicleMake` slug
    func removeMakeFromFavories(slug: String) async throws
}
