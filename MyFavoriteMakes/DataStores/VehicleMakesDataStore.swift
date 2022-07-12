//
//  VehicleMakesDataStore.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 11/07/22.
//

import Foundation
import Combine

/// Data Store for the `VechileMake` entity.
class VehicleMakesDataStore {
    
    // MARK: - Properties
    
    private let dataOrigin: VehicleMakesDataOrigin
    private let favoritesDataOrigin: VehicleMakesFavoritesDataOrigin
    
    private(set) var vehicleMakes = CurrentValueSubject<[VehicleMake], Never>([])
    
    // MARK: - Init
    
    init(
        dataOrigin: VehicleMakesDataOrigin,
        favoritesDataOrigin: VehicleMakesFavoritesDataOrigin
    ) {
        self.dataOrigin = dataOrigin
        self.favoritesDataOrigin = favoritesDataOrigin
    }
    
    // MARK: - Data methods
    
    /// Gets the `VehicleMake` array from the data origins, updates the favorites data and stores
    /// the data in the publisher. Then it returns the publisher content
    ///
    /// - Returns: `[VehicleMake]`
    @discardableResult func getMakes() async throws -> [VehicleMake] {
        let makes = try await dataOrigin.getMakes()
        
        vehicleMakes.value = try await updatingFavoritesOfMakes(makes)
        
        return vehicleMakes.value
    }
    
    // MARK: - Operations
    
    /// Toggles the favorites status for the `VehicleMake` received and updates the publisher's value.
    ///
    /// - Note: Throws `MFMError.notFound` if the `VehicleMake` does not exists in the publisher's data.
    /// - Parameter vehicleMake: the vehicle make to toggle the favorite status for.
    func toggleFavoriteStatusForMake(_ vehicleMake: VehicleMake) async throws {
        guard vehicleMakes.value.contains(where: { $0.slug == vehicleMake.slug }) else {
            throw MFMError.notFound
        }
        
        if vehicleMake.isFavorite {
            try await favoritesDataOrigin.removeMakeFromFavories(slug: vehicleMake.slug)
        } else {
            try await favoritesDataOrigin.addMakeToFavorites(slug: vehicleMake.slug)
        }
        
        vehicleMakes.value = try await updatingFavoritesOfMakes(vehicleMakes.value)
    }
    
    // MARK: - Private Utils
    
    /// Updates the makes cache data getting the favorite status information from the favorites data store.
    /// It creates a new array and returns it.
    /// - Parameter makes: The array of makes to update
    private func updatingFavoritesOfMakes(_ makes: [VehicleMake]) async throws -> [VehicleMake] {
        let favorites = try await favoritesDataOrigin.getFavoritesSlugs()
        
        var updatedMakes = makes
        for index in makes.indices {
            updatedMakes[index].isFavorite = favorites.contains(updatedMakes[index].slug)
        }
        
        return updatedMakes
    }
}
