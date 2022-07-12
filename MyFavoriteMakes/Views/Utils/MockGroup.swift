//
//  MockGroup.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 12/07/22.
//

import SwiftUI
import Resolver

/// `MockGroup` is a group that handles the mocking registration into `Resolver`
/// It also creates a group for each `ColorSchema` available in the system (light and dark)
/// and defines the `previewDevice` to avoid issues when running the app and rendering the preview
struct MockGroup<Content: View>: View {
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        Resolver.Name.mode = .mock
        
        return ForEach(ColorScheme.allCases, id: \.self) {
            Group{
                content()
            }
            .preferredColorScheme($0)
            .previewDevice("iPhone 13")
       }
    }
}

