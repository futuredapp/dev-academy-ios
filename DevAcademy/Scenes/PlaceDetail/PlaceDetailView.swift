import SwiftUI
import MapKit

struct PlaceDetailView: View {
    let state: PlaceDetailViewState
    
    var body: some View {
        ScrollView {
            VStack {
                Text(state.placeType)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .bottom])
                AsyncImage(url: state.placeImageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1))
                } placeholder: {
                    ProgressView()
                }
                .padding(.horizontal)
                Spacer(minLength: 20)
                MapView(coordinate: state.placeCoordinate)
                    .frame(height: 300)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1))
                    .padding(.horizontal)
                Spacer()
            }
            .navigationTitle(state.placeTitle)
        }
    }
}



struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView(state: PlaceDetailViewState(place: Places.mock.places.first!))
    }
}


