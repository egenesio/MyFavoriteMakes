//
//  VehicleMakesListView.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 12/07/22.
//

import SwiftUI
import Resolver

struct VehicleMakesListView: View {
    
    @ObservedObject var viewModel: VehicleMakesViewModel
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.makes) { item in
                VehicleMakeItemView(
                    viewModel: viewModel,
                    item: item
                )
                Divider()
            }
        }
        .navigationTitle("Vehicle Makes")
    }
}

struct VehicleMakesListView_Previews: PreviewProvider {
    
    @InjectedObject static var viewModel: VehicleMakesViewModel
    
    static var previews: some View {
        MockGroup {
            NavigationView {
                VehicleMakesListView(
                    viewModel: viewModel
                )
            }
            .task {
                await viewModel.refreshData()
            }
        }
    }
}
