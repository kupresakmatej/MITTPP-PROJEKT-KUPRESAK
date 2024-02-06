//
//  SearchView.swift
//  Shows
//
//  Created by Matej Kuprešak on 18.09.2023..
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        ZStack {
            Color.primaryBlack
            
            VStack {
                TextField("Search...", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: .infinity)
                    .submitLabel(.search)
                    .padding()
                    .foregroundColor(Color.primaryBlack)
                    .onSubmit {
                        viewModel.fetchData(query: viewModel.searchText)
                    }
                    .background(Color.primaryDarkGray)
                
                ScrollView {
                    ForEach(viewModel.shows, id: \.self) { show in
                        Button {
                            viewModel.onShowTapped?(show)
                        } label: {
                            SearchListElement(show: show, cast: viewModel.cast[show.id] ?? [], viewModel: viewModel)
                        }
                        .accessibilityLabel("SearchElement")
                    }
                }
            }
            .accessibilityLabel("SearchBar")
        }
        .background(Color.primaryDarkGray)
        .foregroundColor(Color.primaryWhite)
        .onAppear {
            viewModel.fetchData(query: viewModel.defaultSearch)
        }
        .onChange(of: viewModel.searchText) { newSearchText in
            viewModel.fetchData(query: newSearchText)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}
