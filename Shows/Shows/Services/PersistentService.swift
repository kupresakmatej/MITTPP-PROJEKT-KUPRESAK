//
//  PersistentService.swift
//  Shows
//
//  Created by Matej Kuprešak on 09.10.2023..
//

import Foundation

protocol FavoritesPersistenceServiceProtocol {
    var favoriteShows: [Show] { get set }
}

class PersistenceService: FavoritesPersistenceServiceProtocol {
    private let userDefaults = UserDefaults.standard
    enum Key: String {
        case shows
        case user
    }
    
    var favoriteShows: [Show] {
        get {
            if let data = userDefaults.object(forKey: Key.shows.rawValue) as? Data {
                do {
                    return try JSONDecoder().decode([Show].self, from: data)
                } catch {
                    print("Error while decoding movie data")
                }
            }
            return []
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                userDefaults.set(data, forKey: Key.shows.rawValue)
            } catch {
                print("Error while encoding movie data")
            }
        }
    }
}
