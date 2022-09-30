//
//  DetailViewModel.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 9/12/22.
//

import Foundation
import Combine


class DetailViewModel: ObservableObject {
    
    @Published var overViewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    @Published var coinDescription: String? = nil
    @Published var webisiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    private let coinDetailService:  DetailDataService
    private var cancellables = Set<AnyCancellable>()
    @Published var coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = DetailDataService(coin: coin)
        self.addSubscriber()
    }
    
    private func addSubscriber() {
        
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistic)
            
            .sink { [weak self] (returnedArrays) in
                self?.overViewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
        
        coinDetailService.$coinDetails
            .sink{
                [weak self ] (returnedCoinsDetails) in
                self?.coinDescription = returnedCoinsDetails?.readableDescription
                self?.webisiteURL = returnedCoinsDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinsDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistic(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
    
        let overviewArray = createOverViewAray(coinModel: coinModel)
        
        let additionalArray = createAdditionalArray(coinModel: coinModel, coinDetailModel: coinDetailModel)
        
        return (overviewArray,additionalArray)
    }
    
   private func createOverViewAray(coinModel: CoinModel) -> [StatisticModel] {
        
        // overviewArray
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentageChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Captalization", value: marketCap, percentageChange: marketCapPercentageChange)
        
        let rank  = ("\(coinModel.rank)")
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overViewArray: [StatisticModel] = [
        priceStat, marketCapStat, rankStat,volumeStat
        ]
        return overViewArray
    }
    
   private func createAdditionalArray(coinModel: CoinModel, coinDetailModel: CoinDetailModel?) -> [StatisticModel] {
        
        //additional
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24h Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange2)
        
        let marketCapChange = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange2 = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange , percentageChange: marketCapPercentageChange2)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ?  "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hasingStat = StatisticModel( title: "Hashing Algorithm", value: hashing)
        
        let additionalArray: [StatisticModel] = [
        highStat,lowStat, priceChangeStat, marketCapChangeStat, blockStat, hasingStat
        ]
        
        return additionalArray
    }
}
