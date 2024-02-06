//
//  DetailsWholeCastView.swift
//  Shows
//
//  Created by Matej Kuprešak on 17.10.2023..
//

import SwiftUI

struct DetailsWholeCastView: View {
    var person: Person
    
    var body: some View {
        VStack() {
            HStack {
                ZStack(alignment: .topLeading) {
                    AsyncImage(url: URL(string: person.image?["original"] ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 80, height: 100)
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 180, height: 220)
                                .aspectRatio(contentMode: .fill)
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
                    .frame(width: 180, height: 220)
                }
            }
            
            Text(person.name)
                .font(.system(size: 11))
                .foregroundColor(Color.primaryWhite)
                .lineLimit(1)
                .frame(maxWidth: 80)
            
            Text(person.character?.name ?? "Unknown character")
                .font(.system(size: 9))
                .foregroundColor(Color.primaryDarkGray)
                .lineLimit(1)
                .frame(maxWidth: 80)
                
            Spacer()
        }
        .background(Color.primaryLightGray)
        .cornerRadius(10)
    }
}

struct DetailsWholeCastView_Previews: PreviewProvider {
    static var person = Person(id: 1, url: "https://www.tvmaze.com/people/1/mike-vogel", name: "Mike Vogel", image: ["original" : "https://static.tvmaze.com/uploads/images/original_untouched/0/1815.jpg"])
    
    static var previews: some View {
        DetailsCastView(person: person)
    }
}

