//
//  MyFavoriteMakesApp.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 11/07/22.
//

import SwiftUI

@main
struct MyFavoriteMakesApp: App {
    
    var isUnitTesting: Bool {
        ProcessInfo.processInfo.arguments.contains("-UNITTEST")
    }
    
    var body: some Scene {
        WindowGroup {
            
            if isUnitTesting {
                EmptyView()
            } else {
                MainView()
            }
        }
    }
    
}

#warning("Add support for UITesting")
