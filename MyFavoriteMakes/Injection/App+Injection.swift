//
//  App+Injection.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 11/07/22.
//

import Foundation
import Resolver

extension Resolver.Name {
    static let live = Self("live")
    static let mock = Self("mock")
    static let test = Self("test")
    
    static let uiTest = Self("ui-test")
    static let uiTestFail = Self("ui-test-fail")
    
    static var mode: Resolver.Name = .live
}

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerDataOrigins()
        registerDataStores()
        registerViewModels()
    }
    
    /// Registers the Data Origins  into the Resolver register
    static func registerDataOrigins() {
        register { resolve(name: .mode) as VehicleMakesDataOrigin }
        register { resolve(name: .mode) as VehicleMakesFavoritesDataOrigin }
        
        // live components
        register(name: .live) { VehicleMakesDataOriginFake() as VehicleMakesDataOrigin }
        register(name: .live) { VehicleMakesFavoritesDataOriginFake() as VehicleMakesFavoritesDataOrigin }
        
        #if DEBUG
        register(name: .mock) { VehicleMakesDataOriginMock() as VehicleMakesDataOrigin }
        register(name: .mock) { VehicleMakesFavoritesDataOriginMock() as VehicleMakesFavoritesDataOrigin }
        
        register(name: .uiTest) { VehicleMakesDataOriginMock() as VehicleMakesDataOrigin }
        register(name: .uiTest) { VehicleMakesFavoritesDataOriginMock() as VehicleMakesFavoritesDataOrigin }
        
        register(name: .uiTestFail) { VehicleMakesDataOriginUITestFailed() as VehicleMakesDataOrigin }
        register(name: .uiTestFail) { VehicleMakesFavoritesDataOriginMock() as VehicleMakesFavoritesDataOrigin }
        #endif
    }
    
    /// Registers the Data Stores  into the Resolver register
    static func registerDataStores() {
        register { VehicleMakesDataStore(dataOrigin: resolve(), favoritesDataOrigin: resolve()) }
    }
    
    /// Registers the View Models  into the Resolver register
    static func registerViewModels() {
        register { VehicleMakesViewModel(dataStore: resolve()) }
    }
    
}
