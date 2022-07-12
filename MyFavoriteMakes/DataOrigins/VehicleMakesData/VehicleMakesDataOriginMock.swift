//
//  VehicleMakesDataOriginMock.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 12/07/22.
//

import Foundation

class VehicleMakesDataOriginMock: VehicleMakesDataOrigin {
    
    static let makes = [
        VehicleMake(id: 1, slug: "alfa-romeo", name: "Alfa Romeo"),
        VehicleMake(id: 20, slug: "audi", name: "Audi", imageUrl: URL(string: "https://www.carlogos.org/logo/Audi-logo.png")!, isFavorite: true),
        VehicleMake(id: 30, slug: "ford", name: "Ford", imageUrl: URL(string: "https://www.carlogos.org/logo/Ford-logo.png")!),
        VehicleMake(id: 40, slug: "honda", name: "Honda", imageUrl: URL(string: "https://www.carlogos.org/car-logos/honda-logo.png")!),
        VehicleMake(id: 230, slug: "toyota", name: "Toyota", isFavorite: true),
        VehicleMake(id: 320, slug: "volvo", name: "Volvo", imageUrl: URL(string: "https://www.carlogos.org/car-logos/volvo-logo.png")!),
    ]
    
    func getMakes() async throws -> [VehicleMake] {
        Self.makes
    }
    
}
