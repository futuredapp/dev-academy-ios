import SwiftUI
import MapKit

struct PlaceDetailView: View {
    let state: PlaceDetailViewState
    
    var body: some View {
        TextEditor(text: .init(
            get: { state.note ?? "" },
            set: { state.note = $0 })
        )
        .foregroundColor(Color.gray)
        .border(Color.red)
        ScrollView {
            VStack {
                HStack(alignment: .center) {
                    Text(state.placeType)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Button {
                        state.isFavourite.wrappedValue.toggle()
                    } label: {
                        Image(systemName: state.isFavourite.wrappedValue ? "heart.fill" : "heart")
                            .foregroundColor(Color.red)
                    }
                }
                .padding([.horizontal, .bottom])
                

                if let placeImageUrl = state.placeImageUrl {
                    AsyncImage(url: placeImageUrl) { image in
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
                }
                Spacer(minLength: 20)
// FIXME: Fix coordinates crash
                if let placeCoordinate = state.placeCoordinate {
                    MapView(coordinate: placeCoordinate)
                        .frame(height: 300)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1))
                        .padding(.horizontal)
                }
                Spacer()
            }
            .navigationTitle(state.placeTitle)
        }
        .onAppear {
            state.loadNote()
        }
        .onDisappear {
            state.saveNoteState()
        }
    }
}



struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView(state: PlaceDetailViewState(place: Places.mock.places.first!))
    }
}


