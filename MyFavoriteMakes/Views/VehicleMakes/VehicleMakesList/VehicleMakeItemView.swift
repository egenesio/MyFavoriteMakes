//
//  VehicleMakeItemView.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 11/07/22.
//

import SwiftUI
import Resolver

struct VehicleMakeItemView: View {
    
    @ObservedObject var viewModel: VehicleMakesViewModel
    var item: VehicleMake
    
    @State private var isFavoriteStateLoading = false
    private let size: CGFloat = 48
    private let cornerRadius: CGFloat = 8
    
    var body: some View {
        HStack(
            spacing: Padding.regular
        ) {
            
            VehicleMakeLogoImage(item: item)
                .padding(Padding.regular)
                .frame(width: size, height: size, alignment: .center)
                .background(Color.primaryColor40)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            
            Text(item.name)
                .font(.headline)
                .lineLimit(1)
            
            Spacer()
            
            if isFavoriteStateLoading {
                ProgressView()
                    .padding(Padding.regular)
            
            } else {
                Button(action: onFavoriteTap) {
                    Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                        .font(.headline)
                        .foregroundColor(Color.red)
                        .padding(Padding.regular)
                }
            }
        }
        .padding(Padding.regular)
    }
 
    private func onFavoriteTap() {
        Task {
            isFavoriteStateLoading = true
            await viewModel.handleOnFavoriteTap(item: item)
            isFavoriteStateLoading = false
        }
    }
}

struct VehicleMakeLogoImage: View {
    
    var item: VehicleMake
    
    var body: some View {
        if let imageUrl = item.imageUrl {
            AsyncImage(url: imageUrl)  { image in
                image
                    .resizable()
                    .scaledToFill()
                
            } placeholder: {
                ProgressView()
            }
        } else {
            Text(item.name.prefix(1))
                .font(.title)
        }
    }
    
}

struct VehicleMakeItemView_Previews: PreviewProvider {
    
    @InjectedObject static var viewModel: VehicleMakesViewModel
    
    static var previews: some View {
        MockGroup {
            
            ScrollView {
                ForEach(VehicleMakesDataOriginMock.makes) { item in
                    VehicleMakeItemView(
                        viewModel: viewModel,
                        item: item
                    )
                    Divider()
                }
            }
        }
    }
}
