//
//  HomeViewModel.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/6/23.
//

import Combine
import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [Statistic] = []
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var isLoading = false
    @Published var searchText = ""
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
 
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // also updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedItems)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // updates market data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        print("Refreshing...")
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(text: String, coins: [Coin], sortOption: SortOption) -> [Coin] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sortOption: sortOption, coins: &updatedCoins)
        
        return updatedCoins
    }

    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercaseText = text.lowercased()
        
        return coins.filter { coin in
            coin.name.lowercased().contains(lowercaseText) ||
            coin.symbol.lowercased().contains(lowercaseText) ||
            coin.id.lowercased().contains(lowercaseText)
        }
    }
    
    private func sortCoins(sortOption: SortOption, coins: inout [Coin]) {
        switch sortOption {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [Coin]) -> [Coin] {
        // will only sort by holdings or reversedHoldings if needed
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [Coin], portfolioItems: [PortfolioItem]) -> [Coin] {
        allCoins.compactMap { (coin) -> Coin? in
            guard let entity = portfolioItems.first(where: { $0.coinId == coin.id }) else { return nil }
            return coin.updateHoldings(amount: entity.amount)
        }
    }

    
    private func mapGlobalMarketData(marketData: MarketData?, portfolioCoins: [Coin]) -> [Statistic] {
        var stats: [Statistic] = []
        
        guard let data = marketData else { return stats }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let bitcoinDominance = Statistic(title: "BTC Dominance", value: data.bitcoinDominance)
        
        let portfolioValue = portfolioCoins
                                .map({ $0.currentHoldingsValue })
                                .reduce(0, +)
        
        let previousValue = portfolioCoins
                                .map { (coin) -> Double in
                                    let currentValue = coin.currentHoldingsValue
                                    let percentChange = coin.percentChange24H / 100.0
                                    return currentValue / (1 + percentChange)
                                }
                                .reduce(0, +)
        
        let percentageChange = (portfolioValue - previousValue) / previousValue * 100
        
        let portfolio = Statistic(title: "Porfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [marketCap, volume, bitcoinDominance, portfolio])
        return stats
    }
}