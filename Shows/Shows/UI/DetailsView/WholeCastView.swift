//
//  WholeCastView.swift
//  Shows
//
//  Created by Matej Kuprešak on 17.10.2023..
//

import SwiftUI

struct WholeCastView: View {
    @ObservedObject var viewModel: DetailsViewModel
    
    let columns = [
        GridItem(.flexible(minimum: 150, maximum: .infinity)),
        GridItem(.flexible(minimum: 150, maximum: .infinity))
    ]
    
    var body: some View {
        ZStack {
            Color.primaryDarkGray
            
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.cast[viewModel.show.id] ?? [], id: \.self) { person in
                        VStack {
                            DetailsWholeCastView(person: person)
                                .padding(.bottom)
                        }
                    }
                }
                .padding(12)
            }
        }
        .background(Color.primaryDarkGray)
    }
}
