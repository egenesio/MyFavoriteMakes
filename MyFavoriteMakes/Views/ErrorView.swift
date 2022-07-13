//
//  ErrorView.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 13/07/22.
//

import SwiftUI

struct ErrorView: View {
    
    var error: Error
    var onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: Padding.large) {
            
            Image(systemName: "exclamationmark.square.fill")
                .font(.system(size: 50))
            
            Text(error.localizedDescription)
                .accessibilityIdentifier("errorText")
            
            Button(action: onRetry) {
                Text("Retry")
                    .withButtonStyle()
            }
            .accessibilityIdentifier("retryButton")
        }
        .foregroundColor(.primaryColor40)
        .padding(Padding.large)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        MockGroup {
            ErrorView(
                error: MFMError.notFound,
                onRetry: {}
            )
        }
    }
}
