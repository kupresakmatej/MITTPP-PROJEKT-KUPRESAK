//
//  SearchBar.swift
//  Shows
//
//  Created by Matej Kuprešak on 20.09.2023..
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        TextField("Search...", text: $searchText)
            .textFieldStyle(.roundedBorder)
            .frame(maxWidth: .infinity)
            .submitLabel(.search)
            .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var searchText = ""
    
    static var previews: some View {
        SearchBar(searchText: $searchText)
    }
}
