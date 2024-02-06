//
//  SearchViewModel.swift
//  Shows
//
//  Created by Matej Kuprešak on 19.09.2023..
//

import Foundation
import SwiftUI

final class SearchViewModel: ObservableObject {
    var onShowTapped: ((_ show: Show) -> Void)?

    @ObservedObject var networkingService = NetworkingService()
    
    @Published var searchText = ""
    
    @Published var defaultSearch = "drama"
    
    @Published var shows = [Show]()
    @Published var cast = [Int: [Person]]()
    
    func getDate(show: Show) -> String {
        let showDate = show.premiered ?? "No release date found"
        
        let date = showDate.split(separator: "-")
        
        let year = date[0]
        
        return String(year)
    }
}

extension SearchViewModel {
    func fetchData(query: String) {
        networkingService.fetchSearchResponse(query: query) { [weak self] result in
            switch result {
            case .success(let response):
                print("SUCCESS")
                DispatchQueue.main.async {
                    let shows = response.map { $0.show }
                    
                    for show in shows {
                        self?.fetchCast(showId: show.id)
                    }
                    
                    self?.shows = shows
                    print("\(shows.count)")
                }
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func fetchCast(showId: Int) {
        networkingService.fetchCast(showID: showId) { [weak self] result in
            switch result {
            case .success(let response):
                print("SUCCESS")
                DispatchQueue.main.async {
                    let cast = response.map { $0.person }
                    
                    self?.cast[showId] = cast
                }
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}
