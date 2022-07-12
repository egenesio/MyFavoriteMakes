//
//  VehicleMakesViewModel.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 11/07/22.
//

import Foundation
import Combine

class VehicleMakesViewModel: ObservableObject {
    
    @Published var uiState = UIState()
    @Published var favoriteMakesCount: Int = 0
    @Published var makes: [VehicleMake] = []
    
    private let dataStore: VehicleMakesDataStore
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(dataStore: VehicleMakesDataStore) {
        self.dataStore = dataStore
        
        uiState = UIState(isLoading: true)
        
        dataStore.vehicleMakes
            .receive(on: RunLoop.main)
            .assign(to: \.makes, on: self)
            .store(in: &subscriptions)
        
        dataStore.vehicleMakes
            .receive(on: RunLoop.main)
            .map { makes in
                makes.favorites.count
            }
            .assign(to: \.favoriteMakesCount, on: self)
            .store(in: &subscriptions)
    }
    
    @MainActor
    func refreshData() async {
        do {
            uiState = UIState(isLoading: true)
            try await dataStore.getMakes()
            uiState = UIState(hasData: true)
        } catch {
            uiState = UIState(error: error)
        }
    }
    
    @MainActor
    func handleOnFavoriteTap(item: VehicleMake) async {
        do {
            try await dataStore.toggleFavoriteStatusForMake(item)
        } catch {
            uiState = UIState(error: error)
        }
    }
}

extension VehicleMakesViewModel {
    
    ///`UIState` struct that contains basic data regarding the current UI state for the `VehicleMake` views.
    struct UIState {
        var isLoading = false
        var hasData = false
        var error: Error? = nil
    }
    
}
