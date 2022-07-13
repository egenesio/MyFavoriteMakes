//
//  MyFavoriteMakesApp.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 11/07/22.
//

import SwiftUI
import Resolver

@main
struct MyFavoriteMakesApp: App {
    
    var launchArgument: MFMAppLaunchArgument?
    
    init() {
        launchArgument = ProcessInfo.processInfo.mfmLaunchArgument
        
        // handle launch arguments to support UI and Unit testing.
        // we register the current namespace (or live by default) for Resolver
        switch ProcessInfo.processInfo.mfmLaunchArgument {
        case .uiTestRegularPath:
            Resolver.Name.mode = .uiTest
            
        case .uiTestErrorPath:
            Resolver.Name.mode = .uiTestFail
            break
            
        case .unitTesting:
            break

        default:
            Resolver.Name.mode = .live
        }
    }
    
    var body: some Scene {
        WindowGroup {
            
            // we do not show UI when unit testing
            if case .unitTesting = launchArgument {
                EmptyView()
            
            // default case
            } else {
                MainView()
            }
        }
    }
}
