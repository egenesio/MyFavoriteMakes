//
//  MFMAppLaunchArgument.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 13/07/22.
//

import Foundation


/// Launch Arguments handled by the app.
/// With this we indicate (if any) what the current run for.
enum MFMAppLaunchArgument: String {
    case unitTesting = "-UNITTEST"
    case uiTestRegularPath = "-UITESTREGULAR"
    case uiTestErrorPath = "-UITESTERROR"
}

extension ProcessInfo {
    var mfmLaunchArgument: MFMAppLaunchArgument? {
        arguments.compactMap { MFMAppLaunchArgument(rawValue: $0) }.first
    }
}
