//
//  UIApplication.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/9/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    // used for removing focus off the keyboard once users are done typing
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
