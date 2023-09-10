//
//  CoinDataService.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/7/23.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [Coin] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }

        // JSON data has snake_case keys which need to be decoded into camelCase variables
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        // creates a network call and updates the allCoins publisher when new data is received
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [Coin].self, decoder: decoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
        
        // the code below is used for testing purposes since the free version of the API limits calls per minute
        /*
        let file = "CoinData.json"
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        guard let loaded = try? decoder.decode([Coin].self, from: data) else {
            fatalError("Faield to decode \(file) from bundle")
        }

        self.allCoins = loaded
        */
    }
}
