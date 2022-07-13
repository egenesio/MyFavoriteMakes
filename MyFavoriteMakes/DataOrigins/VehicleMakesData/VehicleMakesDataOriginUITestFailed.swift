//
//  VehicleMakesDataOriginUITestFailed.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 13/07/22.
//

import Foundation

class VehicleMakesDataOriginUITestFailed: VehicleMakesDataOrigin {
    
    private var shouldReturnError = true
    func getMakes() async throws -> [VehicleMake] {
        if shouldReturnError {
            shouldReturnError = false
            throw MFMError.unavailable
        }
        
        return []
    }
    
}
