//
//  VehicleMakesDataOriginFake.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 11/07/22.
//

import Foundation

class VehicleMakesDataOriginFake: VehicleMakesDataOrigin {
    
    func getMakes() async throws -> [VehicleMake] {
        sleep(UInt32.random(in: 1...2))
        return [
            VehicleMake(id: 1, slug: "alfa-romeo", name: "Alfa Romeo"),
            VehicleMake(id: 20, slug: "audi", name: "Audi", imageUrl: URL(string: "https://www.carlogos.org/logo/Audi-logo.png")!),
            VehicleMake(id: 30, slug: "ford", name: "Ford", imageUrl: URL(string: "https://www.carlogos.org/logo/Ford-logo.png")!),
            VehicleMake(id: 40, slug: "honda", name: "Honda", imageUrl: URL(string: "https://www.carlogos.org/car-logos/honda-logo.png")!),
            VehicleMake(id: 50, slug: "kia", name: "Kia", imageUrl: URL(string: "https://www.carlogos.org/car-logos/kia-logo.png")!),
            VehicleMake(id: 80, slug: "renault", name: "Renault", imageUrl: URL(string: "https://www.carlogos.org/car-logos/renault-logo.png")!),
            VehicleMake(id: 200, slug: "tesla", name: "Tesla", imageUrl: URL(string: "https://www.carlogos.org/car-logos/tesla-logo.png")!),
            VehicleMake(id: 230, slug: "toyota", name: "Toyota"),
            VehicleMake(id: 300, slug: "volkswagen", name: "Volkswagen", imageUrl: URL(string: "https://www.carlogos.org/car-logos/volkswagen-logo.png")!),
            VehicleMake(id: 320, slug: "volvo", name: "Volvo", imageUrl: URL(string: "https://www.carlogos.org/car-logos/volvo-logo.png")!),
        ]
    }
    
}
