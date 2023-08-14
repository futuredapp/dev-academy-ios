import SwiftUI
import MapKit

struct PlaceDetail: View {
    let feature: Feature
    var body: some View {
        ScrollView {
            VStack {
                Text(feature.properties.druh.rawValue)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .bottom])

                AsyncImage(url: feature.properties.obrId1) { image in
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
                MapView(coordinate: CLLocationCoordinate2D(latitude: feature.geometry.latitude, longitude: feature.geometry.longitude))
                    .frame(height: 300)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1))
                    .padding(.horizontal)
                Spacer()
            }
            .navigationTitle(Text(feature.properties.nazev))
        }
    }
}

struct MapView: View {
    let coordinate: CLLocationCoordinate2D

    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))), annotationItems: [IdentifiableCoordinate(coordinate)]) { location in
            MapMarker(coordinate: location.coordinate, tint: .red)
        }
    }
}



struct PlaceDetail_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetail(feature: Features.mock.features[0])
    }
}

struct IdentifiableCoordinate: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D

    init(_ coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
