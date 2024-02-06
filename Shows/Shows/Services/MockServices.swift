//
//  MockFavoritesService.swift
//  Shows
//
//  Created by Matej Kuprešak on 02.02.2024..
//

import Foundation

class MockFavoritesService: FavoritesServiceProtocol {
    var favorites: [Show] = []
    
    func isFavorite(show: Show) -> Bool {
        return favorites.contains(show)
    }
    
    func addToFavorites(show: Show) -> AddToFavoritesResult {
        favorites.append(show)
        return .added
    }
    
    func removeFromFavorites(show: Show) -> RemoveFromFavoritesResult {
        if let index = favorites.firstIndex(of: show) {
            favorites.remove(at: index)
            return .removed
        }
        return .notInFavorites
    }
    
    func toggleFavorite(show: Show) -> ToggleFavoritesResult {
        if isFavorite(show: show) {
            _ = removeFromFavorites(show: show)
            return .removed
        } else {
            _ = addToFavorites(show: show)
            return .added
        }
    }
}

class MockNetworkingService {    
    func fetchHomeScreenShow(showID: Int, completion: @escaping (Result<Show, Error>) -> Void) {
        let dummyShow = Show(id: 1, url: "", name: "", language: "", genres: [], premiered: "", image: [:], rating: Rating(average: 1), airtime: "", summary: "")
        completion(.success(dummyShow))
    }
    
    func fetchHomeScreenSchedule(date: String, completion: @escaping (Result<[HomeScreenSchedule], Error>) -> Void) {
        let emptySchedule: [HomeScreenSchedule] = []
        completion(.success(emptySchedule))
    }
    
    func fetchSearchResponse(query: String, completion: @escaping (Result<[SearchResponse], Error>) -> Void) {
        let emptySearchResponse: [SearchResponse] = []
        completion(.success(emptySearchResponse))
    }
    
    func fetchCast(showID: Int, completion: @escaping (Result<[CastResponse], Error>) -> Void) {
        let emptyCastResponse: [CastResponse] = []
        completion(.success(emptyCastResponse))
    }
}
