//
//  HomeScheduleElement.swift
//  Shows
//
//  Created by Matej Kuprešak on 02.10.2023..
//

import SwiftUI

struct HomeScheduleElement: View {
    let show: Show
    
    @State var isFavorite = false
    
    let favoriteService: FavoritesServiceProtocol
        @State private var favorites: [Show]
        init(favoriteService: FavoritesServiceProtocol, show: Show) {
            self.favoriteService = favoriteService
            self.show = show
            _favorites = State(initialValue: favoriteService.favorites)
        }
    
    func simpleSuccessHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func refresh() {
        favorites = favoriteService.favorites
    }
        
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack(alignment: .topLeading) {
                    AsyncImage(url: URL(string: show.image?["medium"] ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 80, height: 100)
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 160, height: 200)
                                .aspectRatio(contentMode: .fit)
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
                    .frame(width: 160, height: 200)

                    Button {
                        isFavorite.toggle()
                        
                        simpleSuccessHaptic()
                        
                        _ = favoriteService.toggleFavorite(show: show)
                    } label: {
                        FavoriteElement(isFavorite: $isFavorite)
                    }
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text(show.airtime ?? "Unknown airtime")
                        .font(.system(size: 14))
                        .foregroundColor(Color.primaryLightGray)
                        .padding(.trailing, 10)
                }

                Text(show.name)
                    .font(.subheadline)
                    .foregroundColor(Color.primaryWhite)
                    .padding(.bottom)
                    .padding(.leading, 10)
                    .lineLimit(1)
                    .frame(maxWidth: 160, alignment: .leading)
                }
        }
        .background(Color.primaryDarkGray)
        .cornerRadius(10)
        .onAppear {
            isFavorite = favoriteService.isFavorite(show: show)
        }
    }
}
