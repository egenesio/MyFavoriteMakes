//
//  VehicleMakesDataOriginTestFailed.swift
//  MyFavoriteMakesTests
//
//  Created by Emilio Genesio on 12/07/22.
//

import Foundation
@testable import MyFavoriteMakes

class VehicleMakesDataOriginTestFailed: VehicleMakesDataOrigin {
    
    func getMakes() async throws -> [VehicleMake] {
        throw MFMError.unavailable
    }
    
}
