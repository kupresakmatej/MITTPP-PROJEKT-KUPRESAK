//
//  ShowAllElements.swift
//  Shows
//
//  Created by Matej Kuprešak on 17.10.2023..
//

import SwiftUI

struct ShowAllElementsView: View {
    let show: Show
    
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
        }
    }
}
