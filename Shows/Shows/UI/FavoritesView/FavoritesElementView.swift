//
//  FavoritesElementView.swift
//  Shows
//
//  Created by Matej Kuprešak on 09.10.2023..
//

import SwiftUI

struct FavoritesElementView: View {
    let show: Show

    @State var isFavorite = false
    
    let favoriteService: FavoritesServiceProtocol

    init(favoriteService: FavoritesServiceProtocol, show: Show) {
        self.favoriteService = favoriteService
        self.show = show
    }
    
    func refresh() {
        isFavorite = favoriteService.isFavorite(show: show)
    }
    
    func simpleSuccessHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            AsyncImage(url: URL(string: show.image?["original"] ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 100)
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 180, height: 240)
                case .failure:
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                @unknown default:
                    Text("Unknown state")
                }
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 180, height: 240)
            .cornerRadius(25)
            
            Button {
                isFavorite.toggle()
                
                simpleSuccessHaptic()
                
                if !isFavorite {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showUnfavorited"), object: show)
                }
                _ = favoriteService.toggleFavorite(show: show)
            } label: {
                FavoriteElement(isFavorite: $isFavorite)
            }
        }
        .onAppear {
            isFavorite = favoriteService.isFavorite(show: show)
        }
    }
}
