//
//  UtilXCTestCase.swift
//  MyFavoriteMakesTests
//
//  Created by Emilio Genesio on 12/07/22.
//

import XCTest
import Resolver
@testable import MyFavoriteMakes

/// Util `XCTestCase` where to get `.test` registered in Resolver and util methods
class UtilXCTestCase: XCTestCase {
    
    lazy var dataStore: VehicleMakesDataStore = Resolver.resolve()
    
    override class func setUp() {
        super.setUp()
        
        Resolver.Name.mode = .test
    }
    
    /// Registers the `VehicleMakesDataOrigin` implementation in Resolver
    /// - Parameter dataOrigin: a `VehicleMakesDataOrigin` implementation
    static func registerDataOrigin<T: VehicleMakesDataOrigin>(_ dataOrigin: T) {
        Resolver.register(name: .test) { dataOrigin as VehicleMakesDataOrigin }
    }
    
    /// Registers the `VehicleMakesFavoritesDataOrigin` implementation in Resolver
    /// - Parameter dataOrigin: a `VehicleMakesFavoritesDataOrigin` implementation
    static func registerFavoritesDataOrigin<T: VehicleMakesFavoritesDataOrigin>(_ dataOrigin: T) {
        Resolver.register(name: .test) { dataOrigin as VehicleMakesFavoritesDataOrigin }
    }
}
