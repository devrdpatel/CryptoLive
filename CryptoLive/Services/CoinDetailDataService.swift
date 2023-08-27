//
//  CoinDetailDataService.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/17/23.
//

import Foundation
import Combine

class CoinDetailDataService {
    @Published var coinDetails: CoinDetail? = nil
    
    var coinDetailSubscription: AnyCancellable?
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getCoinsDetails()
    }
    
    func getCoinsDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: decoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetail) in
                self?.coinDetails = returnedCoinDetail
                self?.coinDetailSubscription?.cancel()
            })
        
//        let file = "CoinData.json"
//        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
//            fatalError("Failed to locate \(file) in bundle")
//        }
//
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("Failed to load \(file) from bundle")
//        }
//
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//        guard let loaded = try? decoder.decode([Coin].self, from: data) else {
//            fatalError("Faield to decode \(file) from bundle")
//        }
//
//        self.allCoins = loaded
    }
}
