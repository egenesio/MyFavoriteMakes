//
//  MainView.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 11/07/22.
//

import SwiftUI
import Resolver

struct MainView: View {
    
    @InjectedObject var viewModel: VehicleMakesViewModel
    
    var body: some View {
        NavigationView {
            
            if viewModel.uiState.hasData {
                
                FavoritesCountView(viewModel: viewModel)
            
            } else if viewModel.uiState.isLoading {
                
                LoadingView()
            
            } else if let error = viewModel.uiState.error {
                #warning("Add test case for this. Improve UI. Retry needed?")
                Text(error.localizedDescription)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .task {
            await viewModel.refreshData()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MockGroup {
            MainView()
        }
    }
    
}
