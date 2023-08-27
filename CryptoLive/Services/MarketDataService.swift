//
//  MarketDataService.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/10/23.
//

import Combine
import Foundation

class MarketDataService {
    @Published var marketData: MarketData? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
//        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/global") else { return }
//
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//        coinSubscription = NetworkingManager.download(url: url)
//            .decode(type: GlobalData.self, decoder: decoder)
//            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
//                self?.marketData = returnedGlobalData.data
//                self?.coinSubscription?.cancel()
//            })
        
        let file = "MarketData.json"
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        guard let loaded = try? decoder.decode(GlobalData.self, from: data) else {
            fatalError("Faield to decode \(file) from bundle")
        }

        self.marketData = loaded.data
    }
}
