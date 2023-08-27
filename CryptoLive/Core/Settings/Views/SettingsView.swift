//
//  SettingsView.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/20/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftuithinking")!
    let coffeeURL = URL(string: "https://www.buymeacoffe.com/nicksarno")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    
    var body: some View {
        NavigationView {
            List {
                swiftfulThinkingSection
                coingeckoSection
                applicationSection
            }
            .font(.headline)
            .tint(.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    private var swiftfulThinkingSection: some View {
        Section("Swiftful Thinking") {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made following a @SwiftfulThinking course on YouTube. It uses MVVM Architecture, Combine and Core Data.")
                    .font(.callout)
            }
            .padding(.vertical)
            Link("Subscribe on YouTube", destination: youtubeURL)
            Link("Support his coffee addiction", destination: coffeeURL)
        }
    }
    
    private var coingeckoSection: some View {
        Section("CoinGecko") {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko. Prices may be slighly delayed.")
                    .font(.callout)
            }
            .padding(.vertical)
            Link("Visit CoinGecko", destination: coingeckoURL)
        }
    }
    
    private var applicationSection: some View {
        Section("Application") {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        }
    }
}
