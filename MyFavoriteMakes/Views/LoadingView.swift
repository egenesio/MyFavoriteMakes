//
//  LoadingView.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 12/07/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        
        VStack(spacing: Padding.regular) {
            ProgressView()
            
            Text("Loading data")
                .font(.body)
                .foregroundColor(.accent)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        MockGroup {
            LoadingView()
        }
    }
}
