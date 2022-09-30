//
//  PortfolioDataService.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/31/22.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntites: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading core data\(error)")
            }
            self.getPortfolio()
        }
    }
    ///public section
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        
        if let entity = savedEntites.first(where: {$0.coinID == coin.id}) {

            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
                add(coin: coin, amount: amount)
            }
            
            //        if let entity = savedEntites.first(where: { (savedEntity) -> Bool in
//            return savedEntity.coinID == coin.id
        }
    
    
    /// private section
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
           savedEntites = try container.viewContext.fetch(request)
        } catch let error {
            print("error catching core data \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error  {
            print("error saving entity\(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
