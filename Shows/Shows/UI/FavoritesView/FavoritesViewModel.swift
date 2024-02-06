//
//  FavoritesViewModel.swift
//  Shows
//
//  Created by Matej Kuprešak on 27.09.2023..
//

import Foundation
import SwiftUI
import UIKit

final class FavoritesViewModel: ObservableObject {
    @Published var favorites = [Show]()
    
    var onShowTapped: ((_ show: Show) -> Void)?
            
    let favoriteService: FavoritesServiceProtocol
    init(favoriteService: FavoritesServiceProtocol) {
        self.favoriteService = favoriteService
        self.favorites = favoriteService.favorites
    }
    
    func refresh() {
        favorites = favoriteService.favorites
    }
}
