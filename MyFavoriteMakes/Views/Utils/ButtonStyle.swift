//
//  ButtonStyle.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 12/07/22.
//

import SwiftUI

/// Modifier that applies some other modifier to emulate the `Button` style.
struct WithButtonStyleModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.body)
            .frame(height: 44)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, Padding.regular)
            .background(Color.accent)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .foregroundColor(.onAccent)
    }
    
}

extension Text {
    
    /// Applies the `WithButtonStyleModifier` to the current `Text` View.
    func withButtonStyle() -> some View {
        self
            .modifier(WithButtonStyleModifier())
    }
    
}

struct WithButtonStyle_Previews: PreviewProvider {
        
    static var previews: some View {
        MockGroup {
            VStack {
                Text("This is the button")
                    .withButtonStyle()
            }
            .padding()
        }
    }
    
}
