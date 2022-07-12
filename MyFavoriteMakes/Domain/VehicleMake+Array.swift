//
//  VehicleMake+Array.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 12/07/22.
//

import Foundation

extension Array where Element == VehicleMake {

    /// Returns a filter applied to the array returning only the favorites `VehicleMake`
    var favorites: [Element] {
        self.filter { $0.isFavorite }
    }
    
}
