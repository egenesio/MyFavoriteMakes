//
//  VehicleMakesDataOrigin.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 11/07/22.
//

import Foundation

protocol VehicleMakesDataOrigin {
    
    /// Gets the `VehicleMake` entities from the current Origin.
    ///
    /// - Returns: `[VehicleMake]`
    func getMakes() async throws -> [VehicleMake]
}
