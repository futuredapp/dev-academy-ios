import SwiftUI
import CryptoKit

private class ImageStorage {
    static let shared: ImageStorage = ImageStorage()

    /// Select an folder in this application bundle. We want ideally an "Application Support" directory. In this directory, we want to store our images in subdirectory called "imageCache",
    private let defaultPath: URL = { fatalError("Implement me") }()

    /// Initializer first checks, whether folder for `defaultPath` exists. If not, it creates a new one.
    init() {
        fatalError("TODO: Implement me")
    }


    /// Takes an URL as a input and produces SHA256 String of the URL as the output.
    ///
    /// We don't use protocol `Hashable` from two reasons. Firstly, the Apple Documentation explicitly forbids to use `Hashable` and `hashValue` for any purpose related to persistence. The hashes are different at each execution for security reasons. Secondly, the 64-bit `Int` is just too short.
    ///
    /// - Parameter url: URL to be hashed
    /// - Returns: Hashed string
    private func hash(of url: URL) -> String {
        let path = url.description.data(using: .utf8)!
        return SHA256.hash(data: path).compactMap { String(format: "%02x", $0) }.joined()
    }


    /// Check, whether file is already cached and if so, returns an Image.
    ///
    /// The function should have following behavior:
    ///  - Hash the URL
    ///  - Check, whether file names by this hash already exists
    ///  - If so, load it and return it as an Image
    ///
    /// - Parameter url: The URL of the request that would be executed upon the server.
    /// - Returns: Image if exists.
    func loadImage(for url: URL) -> Image? {
        fatalError("TODO: Implement me")

        // HINT: Data -> UIImage
        // let uiimage = UIImage(data: data)
    }


    /// Updates image in the cache.
    ///
    /// The function should have following behavior:
    ///  - Hash the URL
    ///  - Remove existring file (if exists)
    ///  - Create a binary data from the image
    ///  - Save the binary data to the file
    ///
    /// - Parameters:
    ///   - image: Image to be stored
    ///   - url: The URL that was executed upon the server to get this image.
    func update(image: UIImage, at url: URL) {
        fatalError("TODO: Implement me")

        // HINT: UIImage -> Data
        // guard let bytes = image.jpegData(compressionQuality: 1.0) else { return }
    }
}

enum StoredAsyncImageError: Error {
    case decodingFailed
}

struct StoredAsyncImage<I: View, P: View>: View {

    @State private var image: Image?

    private let url: URL
    private let imageBuilder: (Image) -> I
    private let placeholderBuilder: () -> P


    init(url: URL, image: @escaping (Image) -> I, placeholder: @escaping () -> P) {
        self.url = url
        self.imageBuilder = image
        self.placeholderBuilder = placeholder
    }

    private func performURLFetch() async throws -> (UIImage, Image) {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let uiimage = UIImage(data: data) else {
            throw StoredAsyncImageError.decodingFailed
        }
        let image = Image(uiImage: uiimage)

        return (uiimage, image)
    }

    /// Look into the image cache, whether image is already downloaded.
    ///
    /// If so, store it in `image` state variable.
    /// If not, download the image via `performURLFetch()` function, store it in the cache and in the `image` state vriable.
    private func loadImage() async {
        fatalError("TODO: Implement me")
    }

    /// The body should only show one of either states:
    ///
    /// If `image` state variable is filled, present image using `imageBuilder`
    /// If `image` state variable is empty, present `placeholder` and execute `loadImage()` function in the `.task` modifier.
    var body: some View {
        fatalError("TODO: Implement me")
    }
}

struct PlaceRow: View {
    let place: Place

    var body: some View {
        HStack {
            StoredAsyncImage(url: place.attributes.imageUrl!) { image in
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
                Text(place.attributes.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text(place.attributes.type.rawValue)
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
