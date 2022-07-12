//
//  VehicleMake.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 11/07/22.
//

import Foundation

/// `VehicleMake` entity that holds the data.
struct VehicleMake: Identifiable {
    var id: Int
    var slug: String
    var name: String
    var imageUrl: URL? = nil
    
    /// Stores the information regarding if the current `VehicleMake` is was saved as favorite.
    ///
    /// - Note: `true` as default
    var isFavorite: Bool = false
}
