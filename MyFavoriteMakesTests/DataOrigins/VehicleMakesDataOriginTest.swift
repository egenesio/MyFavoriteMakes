//
//  VehicleMakesDataOriginTest.swift
//  MyFavoriteMakesTests
//
//  Created by Emilio Genesio on 12/07/22.
//

import Foundation
@testable import MyFavoriteMakes

class VehicleMakesDataOriginTest: VehicleMakesDataOrigin {
    
    static let makes = [
        VehicleMake(id: 1, slug: "make1", name: "Make 1"),
        VehicleMake(id: 2, slug: "make2", name: "Make 2"),
        VehicleMake(id: 3, slug: "make3", name: "Make 3"),
    ]
    
    func getMakes() async throws -> [VehicleMake] {
        Self.makes
    }
    
}
