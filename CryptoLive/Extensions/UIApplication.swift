//
//  UIApplication.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/9/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
