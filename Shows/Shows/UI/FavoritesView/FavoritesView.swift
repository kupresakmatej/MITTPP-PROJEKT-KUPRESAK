//
//  FavoritesView.swift
//  Shows
//
//  Created by Matej Kuprešak on 25.09.2023..
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel

    let columns = [
        GridItem(.flexible(minimum: 150, maximum: .infinity)),
        GridItem(.flexible(minimum: 150, maximum: .infinity))
    ]

    var body: some View {
        ZStack {
            Color.primaryBlack
                .ignoresSafeArea()

            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.favorites, id: \.id) { show in
                        Button {
                            viewModel.onShowTapped?(show)
                        } label: {
                            FavoritesElementView(favoriteService: viewModel.favoriteService, show: show)
                        }
                        .accessibilityLabel("FavoriteViewElement")
                    }
                }
                .padding(8)
            }
            .onAppear {
                viewModel.refresh()
            }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name(rawValue: "showUnfavorited"))) { _ in
                withAnimation {
                    viewModel.refresh()
                }
            }
        }
    }
}


//struct FavoritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView(viewModel: FavoritesViewModel())
//    }
//}
