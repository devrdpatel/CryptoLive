//
//  String.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/18/23.
//

import Foundation

extension String {
    var removingHTMLOccurrences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
