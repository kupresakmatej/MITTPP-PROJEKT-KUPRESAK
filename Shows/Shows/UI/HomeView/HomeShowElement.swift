import SwiftUI

struct HomeShowElement: View {
    let show: Show
    
    @State var isFavorite = false
    
    let favoriteService: FavoritesServiceProtocol
    
    @State private var favorites: [Show]
    init(favoriteService: FavoritesServiceProtocol, show: Show) {
        self.favoriteService = favoriteService
        self.show = show
        _favorites = State(initialValue: favoriteService.favorites)
    }
    
    func simpleSuccessHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack(alignment: .topLeading) {
                    AsyncImage(url: URL(string: show.image?["original"] ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 80, height: 100)
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 180, height: 220)
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

                    Button {
                        isFavorite.toggle()
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "favorite"), object: isFavorite)
                        
                        simpleSuccessHaptic()
                        
                        _ = favoriteService.toggleFavorite(show: show)
                    } label: {
                        FavoriteElement(isFavorite: $isFavorite)
                    }
                    .accessibilityLabel("FavoriteButton")
                }
            }
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(Color.primaryYellow)
                    .font(.system(size: 14))
                    .padding(.leading, 10)
                
                Text(show.rating?.average.map { String(format: "%.1f", $0) } ?? "")
                    .font(.system(size: 14))
                    .foregroundColor(Color.primaryLightGray)

            }

            Text(show.name)
                .font(.subheadline)
                .foregroundColor(Color.primaryWhite)
                .padding(.bottom)
                .padding(.leading, 10)
                .lineLimit(1)
                .frame(maxWidth: 160, alignment: .leading)
        }
        .background(Color.primaryDarkGray)
        .cornerRadius(10)
        .onAppear {
            isFavorite = favoriteService.isFavorite(show: show)
        }
    }
}

//struct HomeShowElement_Previews: PreviewProvider {
//    static var example = Show(id: 1, url: "https://www.tvmaze.com/shows/1/under-the-dome", name: "Under the Domea a a a a a  a", language: "English", genres: ["Drama","Science-Fiction","Thriller"], premiered: "2013-06-24", image: ["medium": "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg"], rating: Rating(average: 8.0), airtime: "00:35", summary: "")
//
//    static var previews: some View {
//        HomeShowElement(show: example)
//    }
//}
