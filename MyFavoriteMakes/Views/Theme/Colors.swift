//
//  Colors.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 12/07/22.
//

import SwiftUI

extension Color {
    
    static var primaryColor: Color {
        Color.blue
    }
    
    static var primaryColor80: Color {
        primaryColor.opacity(0.8)
    }
    
    static var primaryColor60: Color {
        primaryColor.opacity(0.6)
    }
    
    static var primaryColor40: Color {
        primaryColor.opacity(0.4)
    }
    
    static var accent: Color {
        Color("AccentColor")
    }
    
    static var accent80: Color {
        accent.opacity(0.8)
    }
    
    static var onAccent: Color {
        Color("OnAccentColor")
    }
    
    static var textColor: Color {
        Color("TextColor")
    }
    
    static var textColorInverted: Color {
        Color("TextColorInverted")
    }
}
