//
//  HomeViewModel.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/16/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistic: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOptions: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingReversed, price, priceReversed
    }
    
    init() {
         addSubscriber()
    }
    
    func addSubscriber() {
    
        
        
        ///updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOptions)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            //CREATED A FUNC OF IT SO REMOVED IT
            /*
//            .map { (text, startingCoins) -> [CoinModel] in
//
//                guard !text.isEmpty else {
//                    return startingCoins
//                }
//
//                //Bitcoin -> bitcoin
//                let lowercasedText = text.lowercased()
//
//                let filterCoins = startingCoins.filter { (coin) -> Bool in
//                    return coin.name.lowercased().contains(lowercasedText) ||
//                        coin.symbol.lowercased().contains(lowercasedText) ||
//                        coin.id.lowercased().contains(lowercasedText)
//                }
//                return filterCoins
//            }
            */
            .sink { [weak self](returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        ///updates portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntites)
            .map(mapallCoinsToPortfolioCoins)
            .sink { [weak self](returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortCoinsIfNeeded(coin: returnedCoins)
            }
            .store(in: &cancellables)

        ///updates market Data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            
            // made the func of it n commented it
            /*
//            .map { (marketDataModel) -> [StatisticModel] in
//                var stats: [StatisticModel] = []
//
//                guard let data = marketDataModel else {
//                    return stats
//                }
//                let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
//
//                let volume  = StatisticModel(title: "24h Volume", value: data.volume)
//
//                let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance, percentageChange: 0)
//
//                let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
//
//                stats.append(contentsOf: [
//                marketCap,
//                    volume,
//                    btcDominance,
//                    portfolio
//                ])
//                return stats
//            }
            */
            .sink { [weak self](returnedStats) in
                self?.statistic = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
}
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        hapticManager.notification(type: .success)
    }

    private func filterAndSortCoins(text: String, coin: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins  = filteredCoin(text: text, coins: coin)
        // sort
      sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
        
    }
    
private func filteredCoin(text: String, coins: [CoinModel]) -> [CoinModel] {
    guard !text.isEmpty else {
        return coins
    }
    let lowercasedText = text.lowercased()
    
    return coins.filter { (coin) -> Bool in
    return coin.name.lowercased().contains(lowercasedText) ||
        coin.symbol.lowercased().contains(lowercasedText) ||
        coin.id.lowercased().contains(lowercasedText)
}
}
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel])  {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: {$0.rank < $1.rank})
        case .rankReversed, .holdingReversed:
            coins.sort(by: {$0.rank > $1.rank})
        case .price:
             coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case .priceReversed:
             coins.sort(by: {$0.currentPrice < $1.currentPrice})
//            return coins.sorted { (coin1, coin2) -> Bool in
//                return coin1.rank < coin2.rank
            
        }
    }
    
    private func sortCoinsIfNeeded(coin: [CoinModel]) -> [CoinModel] {
       // will ony sort by holdings or reversedholdings if needed
        switch sortOptions {
        case .holdings:
            return coin.sorted(by: {
                $0.currentHoldingValue > $1.currentHoldingValue
            })
        case .holdingReversed:
            return coin.sorted(by: {
                $0.currentHoldingValue < $1.currentHoldingValue
            })
        default:
            return coin
        }
    }

    private func mapallCoinsToPortfolioCoins(all: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
    
    
    var stats: [StatisticModel] = []
    
    guard let data = marketDataModel else {
        return stats
    }
    let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
    
    let volume  = StatisticModel(title: "24h Volume", value: data.volume)
        
       
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance, percentageChange: Double(data.btcDominancePer))
        
//        let portfolioValue = portfolioCoins.map { (coin) -> Double in
//            return coin.currentHoldingValue
//        } // CONDENSED CODE DOWN BELOW
        
        let portfolioValue = portfolioCoins.map({$0.currentHoldingValue})
            .reduce(0, +)
        
        let previousValue = portfolioCoins.map { (coin) -> Double in
            let currentValue = coin.currentHoldingValue
            let percentChange = coin.priceChangePercentage24H ??  0 /   100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }
        .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        
        /// 110 / (1 + 0.1) = 100
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange:  percentageChange)
    
    stats.append(contentsOf: [
    marketCap,
        volume,
        btcDominance,
        portfolio
    ])
    return stats
}
}
