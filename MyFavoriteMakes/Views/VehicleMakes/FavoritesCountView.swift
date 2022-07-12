//
//  FavoritesCountView.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 12/07/22.
//

import SwiftUI
import Resolver

struct FavoritesCountView: View {
    
    @ObservedObject var viewModel: VehicleMakesViewModel
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: Padding.nothing
        ) {
            
            Text("You have")
                .font(.largeTitle.italic())
                .foregroundColor(.primaryColor60)
                .fontWeight(.black)
            
            Text("\(viewModel.favoriteMakesCount)")
                .font(.system(size: 50).weight(.bold))
                .foregroundColor(.primaryColor)
            
            Text("favorites vehicle makes")
                .font(.largeTitle.italic())
                .foregroundColor(.primaryColor60)
                .fontWeight(.black)
            
            Spacer()
            
            NavigationLink(
                destination: {
                    VehicleMakesListView(viewModel: viewModel)
                }
            ) {
                
                Text("See all vehicle makes")
                    .withButtonStyle()
                
            }
            .padding([.bottom], Padding.large)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(Padding.large)
    }
}

struct FavoritesCountView_Previews: PreviewProvider {
    
    @InjectedObject static var viewModel: VehicleMakesViewModel
    
    static var previews: some View {
        MockGroup {
            NavigationView {
                FavoritesCountView(
                    viewModel: viewModel
                )
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .task {
                await viewModel.refreshData()
            }
        }
    }
    
}
