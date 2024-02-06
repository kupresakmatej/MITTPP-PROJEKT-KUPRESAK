//
//  FavoriteElement.swift
//  Shows
//
//  Created by Matej Kuprešak on 03.10.2023..
//

import SwiftUI

struct FavoriteElement: View {
    @Binding var isFavorite: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 44, height: 44)
                .foregroundColor(Color.primaryBlack)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 1)
                )
            
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 14, height: 14)
                .foregroundColor(isFavorite ? Color.primaryYellow : Color.primaryLightGray)
        }
    }
}


//struct FavoriteElement_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteElement(isFavorite: false)
//    }
//}
