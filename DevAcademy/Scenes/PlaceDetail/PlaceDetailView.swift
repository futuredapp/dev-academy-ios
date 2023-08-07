import SwiftUI
import MapKit

struct PlaceDetailView: View {
    let place: Place
    
    var body: some View {
        ScrollView {
            VStack {
                Text(place.properties.druh.rawValue)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .bottom])

                AsyncImage(url: place.properties.obrId1) { image in
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
                MapView(coordinate: CLLocationCoordinate2D(latitude: place.geometry.latitude, longitude: place.geometry.longitude))
                    .frame(height: 300)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1))
                    .padding(.horizontal)
                Spacer()
            }
            .navigationTitle(Text(place.properties.nazev))
        }
    }
}



struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView(place: Places.mock.places.first!)
    }
}


