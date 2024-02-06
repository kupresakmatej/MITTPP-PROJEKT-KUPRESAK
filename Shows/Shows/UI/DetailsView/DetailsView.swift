//
//  DetailsView.swift
//  Shows
//
//  Created by Matej Kuprešak on 03.10.2023..
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject var viewModel: DetailsViewModel
    
    @State var isFavorite = false
    
    func simpleSuccessHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    var body: some View {
        ZStack {
            Color.primaryBlack
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    AsyncImage(url: URL(string: viewModel.show.image?["original"] ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 80, height: 100)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 400, height: 400)
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
                    .frame(width: 220, height: 400)
                    
                    VStack {
                        Button {
                            viewModel.toggleFavorites()
                            
                            simpleSuccessHaptic()
                            
                            DispatchQueue.main.async {
                                isFavorite = viewModel.isFavorite
                                viewModel.refresh()
                            }
                        } label: {
                            FavoriteElement(isFavorite: $isFavorite)
                                .frame(width: 52, height: 52)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()

                        Spacer()
                    }
                }
                
                Text(viewModel.show.summary?.removingHTMLTags ?? "Summary not found")
                    .font(.system(size: 16))
                    .foregroundColor(Color.primaryLightGray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                
                Spacer()
                
                HStack {
                    Text("Cast")
                        .font(.title2.bold())
                        .foregroundColor(Color.primaryLightGray)
                    
                    Spacer()
                    
                    Button() {
                        viewModel.isShowAllTapped.toggle()
                    } label: {
                        Text("show all")
                            .font(.subheadline.bold())
                            .foregroundColor(Color.yellow)
                    }
                    .sheet(isPresented: $viewModel.isShowAllTapped) {
                        WholeCastView(viewModel: viewModel)
                    }
                    .padding(.trailing)
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.cast[viewModel.show.id] ?? [], id: \.self) { person in
                            VStack {
                                DetailsCastView(person: person)
                                    .padding(.bottom)
                            }
                        }
                    }
                }
                Spacer()
                Spacer()
            }
        }
        .onAppear {
            viewModel.fetchCast(showId: viewModel.show.id)
            
            viewModel.refresh()
            
            isFavorite = viewModel.isFavorite
        }
        .accessibilityIdentifier("DetailsView")
    }
}

//struct DetailsView_Previews: PreviewProvider {
//    static var example = Show(id: 1, url: "https://www.tvmaze.com/shows/1/under-the-dome", name: "Under the Dome", language: "English", genres: ["Drama","Science-Fiction","Thriller"], premiered: "2013-06-24", image: ["original": "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg"], rating: Rating(average: 8.0), airtime: "00:35", summary: "Under the Dome is the story of a small town that is suddenly and inexplicably sealed off from the rest of the world by an enormous transparent dome. The town's inhabitants must deal with surviving the post-apocalyptic conditions while searching for answers about the dome, where it came from and if and when it will go away.")
//
//    static var previews: some View {
//        DetailsView(viewModel: DetailsViewModel())
//    }
//}
