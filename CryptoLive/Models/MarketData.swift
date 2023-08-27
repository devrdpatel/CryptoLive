//
//  MarketDataModel.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/10/23.
//

import Foundation

// JSON Data:
/*
 
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 {
     "data": {
       "active_cryptocurrencies": 10031,
       "upcoming_icos": 0,
       "ongoing_icos": 49,
       "ended_icos": 3376,
       "markets": 807,
       "total_market_cap": {
         "btc": 41455031.43715171,
         "eth": 659161483.4058741,
         "ltc": 14681525937.964127,
         "bch": 5248548463.669069,
         "bnb": 5061927931.984604,
         "eos": 1700002313935.2422,
         "xrp": 1923487810488.1328,
         "xlm": 8776675515604.455,
         "link": 160327492336.6209,
         "dot": 244127531125.36493,
         "yfi": 191561477.3749713,
         "usd": 1220007858677.0767,
         "aed": 4481155965353.137,
         "ars": 349081702608773.5,
         "aud": 1872006898527.001,
         "bdt": 133529434349463.28,
         "bhd": 459891722391.19305,
         "bmd": 1220007858677.0767,
         "brl": 5969498452506.923,
         "cad": 1640478687138.6968,
         "chf": 1069685810378.0388,
         "clp": 1033904964835826.8,
         "cny": 8804064711357.248,
         "czk": 26911549450667.598,
         "dkk": 8277470279300.759,
         "eur": 1110906215899.1619,
         "gbp": 962477619796.7941,
         "hkd": 9539457388387.06,
         "huf": 428200544492565.2,
         "idr": 18620790182085868,
         "ils": 4524874946968.825,
         "inr": 101145962991426.64,
         "jpy": 176659908549887.84,
         "krw": 1606117852663482,
         "kwd": 375331757698.4271,
         "lkr": 390119095971023.6,
         "mmk": 2562002966014664,
         "mxn": 20851898517443.727,
         "myr": 5577875929871.606,
         "ngn": 938481625606663.8,
         "nok": 12587638483236.705,
         "nzd": 2026032890684.9785,
         "php": 68610797076249.9,
         "pkr": 350875815665547.5,
         "pln": 4937898847461.103,
         "rub": 118371252728080.67,
         "sar": 4577070543186.591,
         "sek": 13055768918697.578,
         "sgd": 1645632000333.7505,
         "thb": 42826412886214.164,
         "try": 33010227215282.727,
         "twd": 38752573624590.42,
         "uah": 44829426668621.87,
         "vef": 122159386889.33592,
         "vnd": 28971928935896096,
         "zar": 22986474287307.332,
         "xdr": 912551238196.1517,
         "xag": 53737734951.463615,
         "xau": 637807908.437789,
         "bits": 41455031437151.71,
         "sats": 4145503143715171
       },
       "total_volume": {
         "btc": 1071383.665157245,
         "eth": 17035684.72966992,
         "ltc": 379436380.1982419,
         "bch": 135645997.47768408,
         "bnb": 130822887.17482927,
         "eos": 43935673107.40119,
         "xrp": 49711539199.055855,
         "xlm": 226828600915.66797,
         "link": 4143580414.9731736,
         "dot": 6309348708.598006,
         "yfi": 4950806.46710118,
         "usd": 31530466769.31664,
         "aed": 115813138619.3725,
         "ars": 9021834528031.32,
         "aud": 48381041881.108475,
         "bdt": 3450998583768.802,
         "bhd": 11885661692.428053,
         "bmd": 31530466769.31664,
         "brl": 154278573902.26596,
         "cad": 42397316019.49455,
         "chf": 27645471836.802048,
         "clp": 26720734546527.438,
         "cny": 227536460394.0964,
         "czk": 695514958883.3052,
         "dkk": 213926901961.5231,
         "eur": 28710791717.536964,
         "gbp": 24874732069.448433,
         "hkd": 246542300561.9053,
         "huf": 11066619729291.26,
         "idr": 481244609925157.1,
         "ils": 116943032896.05086,
         "inr": 2614064657263.6963,
         "jpy": 4565683193256.4795,
         "krw": 41509278174589.56,
         "kwd": 9700253510.17997,
         "lkr": 10082424554976.625,
         "mmk": 66213630353505.75,
         "mxn": 538906441139.1204,
         "myr": 144157294069.31598,
         "ngn": 24254568115562.883,
         "nok": 325320951071.775,
         "nzd": 52361763310.73461,
         "php": 1773210264050.9595,
         "pkr": 9068202444200.61,
         "pln": 127617420177.06943,
         "rub": 3059243286049.218,
         "sar": 118292000855.84212,
         "sek": 337419538006.2971,
         "sgd": 42530500711.12819,
         "thb": 1106826303415.8289,
         "try": 853132104728.9746,
         "twd": 1001540052553.9282,
         "uah": 1158593149879.5662,
         "vef": 3157145637.6116815,
         "vnd": 748764392015337.4,
         "zar": 594073438547.854,
         "xdr": 23584410777.84768,
         "xag": 1388823731.0067627,
         "xau": 16483812.722331049,
         "bits": 1071383665157.245,
         "sats": 107138366515724.5
       },
       "market_cap_percentage": {
         "btc": 46.92682727666655,
         "eth": 18.215677412268967,
         "usdt": 6.841794098988465,
         "bnb": 3.0387651864760206,
         "xrp": 2.744841118939436,
         "usdc": 2.1447027847520386,
         "steth": 1.2188529885723658,
         "doge": 0.8711819991481154,
         "ada": 0.8532966812261369,
         "sol": 0.8199614190145023
       },
       "market_cap_change_percentage_24h_usd": -0.1296662198298993,
       "updated_at": 1691706575
    }
}
 */

struct GlobalData: Codable {
    let data: MarketData?
}

struct MarketData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    var marketCap: String {
        "$\(totalMarketCap["usd", default: 0.0].formattedWithAbbreviations())"
    }
    
    var volume: String {
        "$\(totalVolume["usd", default: 0.0].formattedWithAbbreviations())"
    }
    
    var bitcoinDominance: String {
        "\(marketCapPercentage["btc", default: 0.0].asPercentString())"
    }
}