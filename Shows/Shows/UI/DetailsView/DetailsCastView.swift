//
//  DetailsCastView.swift
//  Shows
//
//  Created by Matej Kuprešak on 04.10.2023..
//

import SwiftUI

struct DetailsCastView: View {
    var person: Person
    
    var body: some View {
        ZStack {
            Color.primaryBlack
                .ignoresSafeArea()
            
            VStack {
                AsyncImage(url: URL(string: person.image?["original"] ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 80, height: 100)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90)
                            .clipped()
                            .ignoresSafeArea()
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
                .frame(width: 80, height: 80)
                .padding(.bottom, 20)
                .clipped()
                                
                Text(person.name)
                    .font(.system(size: 11))
                    .foregroundColor(Color.primaryWhite)
                    .lineLimit(1)
                    .frame(maxWidth: 80)
                
                Text(person.character?.name ?? "Unknown character")
                    .font(.system(size: 9))
                    .foregroundColor(Color.primaryLightGray)
                    .lineLimit(1)
                    .frame(maxWidth: 80)
            }
        }
        .cornerRadius(10)
    }
}

struct DetailsCastView_Previews: PreviewProvider {
    static var person = Person(id: 1, url: "https://www.tvmaze.com/people/1/mike-vogel", name: "Mike Vogel", image: ["original" : "https://static.tvmaze.com/uploads/images/original_untouched/0/1815.jpg"])
    
    static var previews: some View {
        DetailsCastView(person: person)
    }
}
