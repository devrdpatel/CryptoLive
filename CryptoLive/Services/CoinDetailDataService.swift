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

        // JSON data has snake_case keys which need to be decoded into camelCase variables
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        // creates a network call and updates coinDetails publisher when new data is received
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: decoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetail) in
                self?.coinDetails = returnedCoinDetail
                self?.coinDetailSubscription?.cancel()
            })
    }
}
