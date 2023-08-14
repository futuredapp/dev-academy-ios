import SwiftUI

struct PlaceRow: View {
    let place: Place

    var body: some View {
        HStack {
            AsyncImage(url: place.properties.obrId1) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 4)
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text(place.properties.nazev)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text(place.properties.druh.rawValue)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
        }
    }
}


struct PlaceRow_Previews: PreviewProvider {
    static var previews: some View {
        PlaceRow(place: Places.mock.places[0])
    }
}
