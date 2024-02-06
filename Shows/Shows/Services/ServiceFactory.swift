//
//  ServiceFactory.swift
//  Shows
//
//  Created by Matej Kuprešak on 09.10.2023..
//

import Foundation

class ServiceFactory {
    lazy var favoriteService: FavoritesServiceProtocol = {
        FavoriteService(persistenceService: persistenceService)
    }()
    
    lazy var persistenceService: FavoritesPersistenceServiceProtocol  = {
        PersistenceService()
    }()
}
