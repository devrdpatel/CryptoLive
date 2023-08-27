//
//  DetailViewModel.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/17/23.
//

import Combine
import Foundation

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [Statistic] = []
    @Published var additionalStatistics: [Statistic] = []
    @Published var coinDesc: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    @Published var coin: Coin
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailDataService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] (returnedArrays) in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
        
        coinDetailDataService.$coinDetails
            .sink { [weak self] (returnedCoinDetails) in
                self?.coinDesc = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditUrl
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetail: CoinDetail?, coin: Coin) -> (overview: [Statistic], additional: [Statistic]) {
        return (
            createOverviewArray(coin: coin),
            createAdditionalArray(coinDetail: coinDetail, coin: coin)
        )
    }
    
    private func createOverviewArray(coin: Coin) -> [Statistic] {

        let price = coin.currentPrice.asCurrencyWith6Decimals()
        let percentChange = coin.percentChange24H
        let priceStat = Statistic(title: "Currrent Price", value: price, percentageChange: percentChange)

        let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStat = Statistic(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)

        let rankStat = Statistic(title: "Rank", value: String(coin.rank))

        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = Statistic(title: "Volume", value: volume)

        let overviewArray: [Statistic] = [
        priceStat, marketCapStat, rankStat, volumeStat
        ]
        
        return overviewArray
    }
    
    private func createAdditionalArray(coinDetail: CoinDetail?, coin: Coin) -> [Statistic] {
        // additional
        let high = coin.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = Statistic(title: "24h High", value: high)

        let low = coin.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = Statistic(title: "24 Low", value: low)

        let priceChange = coin.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange = coin.percentChange24H
        let priceChangeStat = Statistic(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)

        let marketCapChange = "$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)

        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime) min"
        let blockStat = Statistic(title: "Block Time", value: blockTimeString)

        let hashing = coinDetail?.hashingAlgorithm ?? "n/a"
        let hashingStat = Statistic(title: "Hashing Algorithm", value: hashing)

        let additionalArray: [Statistic] = [
        highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ]
        
        return additionalArray
    }
}
