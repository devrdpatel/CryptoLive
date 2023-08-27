//
//  Coin.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/6/23.
//

import Foundation

// Coin Gecko API Info
/*
 
 URL:
    https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en
 
 JSON Response:
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
     "current_price": 28993,
     "market_cap": 564189213765,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 609161676851,
     "total_volume": 5696550985,
     "high_24h": 29084,
     "low_24h": 28973,
     "price_change_24h": -48.58658931833634,
     "price_change_percentage_24h": -0.1673,
     "market_cap_change_24h": -123925944.82116699,
     "market_cap_change_percentage_24h": -0.02196,
     "circulating_supply": 19449637,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 69045,
     "ath_change_percentage": -57.98712,
     "ath_date": "2021-11-10T14:24:11.849Z",
     "atl": 67.81,
     "atl_change_percentage": 42678.5381,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2023-08-06T14:49:02.283Z",
     "sparkline_in_7d": {
       "price": [
         29280.924410272044,
         29317.606859109263,
       ]
     },
     "price_change_percentage_24h_in_currency": -0.16729990478142767
 }
 */

struct Coin: Identifiable, Codable, Equatable {
    
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
    let currentHoldings: Double?
    
    func updateHoldings(amount: Double) -> Coin {
        return Coin(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        Int(marketCapRank ?? 0)
    }
    
    var percentChange24H: Double {
        priceChangePercentage24H ?? 0
    }
    
    static func == (lhs: Coin, rhs: Coin) -> Bool {
        lhs.id == rhs.id
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
