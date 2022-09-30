//
//  CoinImageViewModel.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/16/22.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading = false
    
    private let dataService: CoinImageService
    private let coin: CoinModel
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscriber()
        self.isLoading = true
    }
    
    private func addSubscriber() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self ](returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
