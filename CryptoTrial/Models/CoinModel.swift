//
//  CoinModel.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/16/22.
//

import Foundation

/*
 URL : https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h
 
 JSON REsponse
 {
   "id": "bitcoin",
   "symbol": "btc",
   "name": "Bitcoin",
   "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
   "current_price": 23951,
   "market_cap": 458197766364,
   "market_cap_rank": 1,
   "fully_diluted_valuation": 503162052503,
   "total_volume": 26346881049,
   "high_24h": 24239,
   "low_24h": 23724,
   "price_change_24h": -95.89240712011815,
   "price_change_percentage_24h": -0.39877,
   "market_cap_change_24h": -2296135273.6417847,
   "market_cap_change_percentage_24h": -0.49862,
   "circulating_supply": 19123368,
   "total_supply": 21000000,
   "max_supply": 21000000,
   "ath": 69045,
   "ath_change_percentage": -65.32623,
   "ath_date": "2021-11-10T14:24:11.849Z",
   "atl": 67.81,
   "atl_change_percentage": 35205.67313,
   "atl_date": "2013-07-06T00:00:00.000Z",
   "roi": null,
   "last_updated": "2022-08-16T19:57:27.898Z",
   "sparkline_in_7d": {
     "price": [
       23073.71899930757,
       23107.484165356927,
       23225.483443665544,
       23211.524629817377,
       23167.70136242787,
       23203.680696781623,
       22826.073530150657,
       22877.316516211962,
       22887.17055941663,
       22857.325173268782,
       22885.825565257455,
       22953.898050290587,
       22939.03207343407,
       23014.554292044653,
       23102.833448748,
       23075.173964099402,
       23084.701531320035,
       23130.367314799052,
       23882.679186586374,
       24058.48718001248,
       24046.97547509342,
       24043.147762090262,
       23992.801206799897,
       23937.969381825435,
       23575.839566816594,
       23637.921228539275,
       23858.790451645888,
       23947.125380871003,
       23927.586063607472,
       23956.114928297182,
       24087.035241627607,
       24446.368391825537,
       24307.557304436214,
       24326.911472235464,
       24490.58130447118,
       24621.83096426009,
       24569.821422466724,
       24490.57402255978,
       24500.144786305915,
       24507.210496033556,
       24514.23497387698,
       24608.741447076845,
       24750.869105965743,
       24708.158332296127,
       24593.649986082517,
       24367.54356335173,
       24325.71353510799,
       24388.56922976156,
       24150.091400321773,
       24193.37814489201,
       24219.942651915677,
       24129.803153214303,
       24111.90487480591,
       23950.900748828608,
       24015.969963785228,
       23921.91365732237,
       24040.56657565661,
       24039.87614251933,
       23955.553467873222,
       23976.45745076446,
       23948.999232435446,
       23971.86434935384,
       23969.770416163203,
       24137.763410869182,
       23848.085959774355,
       23687.14585329236,
       23815.364885516134,
       23857.303258727206,
       23891.997148712064,
       24007.897810196515,
       24029.108118547705,
       24046.10842201185,
       24242.726709539424,
       24212.295241973974,
       24191.222378302533,
       24153.31732524531,
       24235.476736991295,
       24411.379871522615,
       24435.206415726083,
       24516.54535285888,
       24581.200022300523,
       24806.972862863026,
       24754.624961807658,
       24728.56091301459,
       24670.33231956203,
       24587.952742835758,
       24502.23458932294,
       24562.497295302823,
       24529.943244746937,
       24456.71021564192,
       24451.476269891682,
       24483.686334152146,
       24520.138912434322,
       24540.913975452782,
       24509.55007266706,
       24611.86772139833,
       24452.406234442795,
       24494.879491242547,
       24526.566260019863,
       24513.0326931169,
       24433.026804829362,
       24439.40503794657,
       24515.79335901036,
       24635.232115374485,
       24617.896631226857,
       24603.65207882515,
       24589.65354958448,
       24577.292655509813,
       24659.870631207952,
       24988.449475661626,
       24643.359261763733,
       24772.37944424216,
       24656.75689714216,
       24574.352418318893,
       24547.996738292055,
       24474.124965595034,
       24524.7664485601,
       24549.692072795377,
       24451.904381101955,
       24306.625499799313,
       24319.996575751942,
       24313.46902859821,
       24333.650926373277,
       24376.724057770207,
       24367.76439390337,
       24322.437555352866,
       24411.791514620556,
       24577.730692681183,
       24892.936780864195,
       24995.084223759943,
       24884.91283602995,
       24841.424255139827,
       24359.512044551775,
       24118.673158385813,
       24087.449123655966,
       24149.979354929605,
       24274.471905594513,
       24107.988781346365,
       24001.62167238593,
       24147.06355441763,
       24153.392768749545,
       24240.352140749193,
       24237.60721046364,
       24119.538790648603,
       24138.152072266173,
       24055.313178402615,
       24031.54671364497,
       24036.232181401978,
       24054.94024317822,
       24179.014652309197,
       24152.310262387586,
       24201.106463423406,
       24103.166778587474,
       24144.16494015081,
       24021.41594466998,
       23933.19694910469,
       24012.322379761114,
       24038.356192318424,
       24037.556123300023,
       24104.118934862243,
       24032.547116099853,
       24043.493030561047,
       23993.556702232025,
       23908.5616049927,
       23748.937384747824,
       23927.207054359013,
       23814.265235958344,
       23883.60836805648
     ]
   }
 */



    struct CoinModel: Identifiable, Codable {
        let id, symbol, name: String
        let image: String
        let currentPrice: Double
        let marketCap, marketCapRank, fullyDilutedValuation: Double?
        let totalVolume, high24H, low24H: Double?
        let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
        let circulatingSupply, totalSupply, maxSupply, ath: Double?
        let athChangePercentage: Double?
        let athDate: String?
        let atl, atlChangePercentage: Double?
        let atlDate: String?
       
        let lastUpdated: String?
        let sparklineIn7D: SparklineIn7D?
        let priceChangePercentage24HInCurrency: Double?
        let curentHoldings: Double?
        
        enum CodingKeys: String, CodingKey {
            case id, symbol, name, image
            case currentPrice = "current_price"
            case marketCap = "market_cap"
            case marketCapRank = "market_cap_rank"
            case fullyDilutedValuation = "fully_diluted_valuation"
            case totalVolume = "total_volume"
            case high24H = "high_24h"
            case low24H = "low_24h"
            case priceChange24H = "price_change_24h"
            case priceChangePercentage24H = "price_change_percentage_24h"
            case marketCapChange24H = "market_cap_change_24h"
            case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
            case circulatingSupply = "circulating_supply"
            case totalSupply = "total_supply"
            case maxSupply = "max_supply"
            case ath
            case athChangePercentage = "ath_change_percentage"
            case athDate = "ath_date"
            case atl
            case atlChangePercentage = "atl_change_percentage"
            case atlDate = "atl_date"
            case lastUpdated = "last_updated"
            case sparklineIn7D = "sparkline_in_7d"
            case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
            case curentHoldings
        }
        
        func updateHoldings(amount: Double) -> CoinModel {
            return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, curentHoldings: amount)
        }
        
        var currentHoldingValue: Double {
          return (curentHoldings ?? 0) * currentPrice
        }
        
        var rank: Int {
            return Int(marketCapRank ?? 0 )
        }
        
    }
        
    struct SparklineIn7D: Codable {
        let price: [Double]?
    }


