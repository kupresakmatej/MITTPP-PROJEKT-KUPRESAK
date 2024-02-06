//
//  HomeScheduleSheetView.swift
//  Shows
//
//  Created by Matej Kuprešak on 17.10.2023..
//

import SwiftUI

struct HomeSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: HomeViewModel
    
    var shows: [Show]
    
    let columns = [
        GridItem(.flexible(minimum: 150, maximum: .infinity)),
        GridItem(.flexible(minimum: 150, maximum: .infinity))
    ]
    
    var body: some View {
        ZStack {
            Color.primaryDarkGray
            
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(shows, id: \.id) { show in
                        Button {
                            dismiss()
                            
                            viewModel.onShowTapped?(show)
                        } label: {
                            ShowAllElementsView(show: show)
                        }
                    }
                }
                .padding(8)
            }
        }
        .background(Color.primaryDarkGray)
    }
}
