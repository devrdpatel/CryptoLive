//
//  JSONDecoder.swift
//  CryptoLive
//
//  Created by Dev Patel on 9/10/23.
//

import Foundation

extension JSONDecoder {
    var convertSnakeCase: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
