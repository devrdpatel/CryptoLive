//
//  PortfolioDataService.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/13/23.
//

import CoreData
import Foundation

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioItem"
    
    @Published var savedItems: [PortfolioItem] = []
    
    init() {
        self.container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading from Core Data: \(error.localizedDescription)")
            }
            self.getPorfolio()
        }
    }
    
    // MARK: PUBLIC
    
    func updatePortfolio(coin: Coin, amount: Double) {
        
        // check if coin is already in portfolio
        if let item = savedItems.first(where: { $0.coinId == coin.id }) {
            if amount > 0 {
                update(entity: item, amount: amount)
            } else {
                delete(entity: item)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: PRIVATE
    
    private func getPorfolio() {
        let request = NSFetchRequest<PortfolioItem>(entityName: entityName)
        do {
            savedItems = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching portfolio items. \(error.localizedDescription)")
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let portfolioItem = PortfolioItem(context: container.viewContext)
        portfolioItem.coinId = coin.id
        portfolioItem.amount = amount
        
        // Generally, it's better to append new item to entity array
        applyChanges()
    }
    
    private func update(entity: PortfolioItem, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioItem) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPorfolio()
    }
}
