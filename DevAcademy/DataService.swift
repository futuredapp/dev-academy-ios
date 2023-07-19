import Foundation

enum Kind: String {
    case divadlo = "Divadlo"
    case galerie = "Galerie"
    case hub = "Hub"
    case hudebniKlub = "Hudebni klub"
    case kino = "Kino"
    case knihovna = "Knihovna"
    case koncertniHala = "Koncertní hala"
    case kulturniCentrum = "Kulturní centrum"
    case kulturniPamátka = "Kulturní památka"
    case letniKino = "Letní kino"
    case muzeum = "Muzeum"
    case podnikSLulturnimProgramem = "Podnik s kulturním programem"
    case vystaviste = "Výstaviště"
    case ostatni = "Ostatní"
}

enum PossibleKind: RawRepresentable {
    case kind(Kind)
    case unknown(String)

    typealias RawValue = String

    var rawValue: String {
        switch self {
        case .kind(let kind):
            return kind.rawValue
        case .unknown(let string):
            return string
        }
    }

    init?(rawValue: String) {
        if let kind = Kind(rawValue: rawValue) {
            self = .kind(kind)
        } else {
            self = .unknown(rawValue)
        }
    }
}

struct Features {
    var features: [Feature]
}

struct Feature {
    var geometry: Point
    var properties: Properties
}

struct Point {
    var latitude: Double
    var longitude: Double
}

struct Properties {
    var ogcFid: Int
    var obrId1: URL
    var druh: PossibleKind
    var nazev: String
}

final class DataService {

    var data: Result<Features, Error>? = nil

    static let shared = DataService()
    private init() {}

    func fetchData(_ handler: @escaping (Result<Features, Error>) -> Void) {
        if let data {
            handler(data)
            return
        }

        Timer.scheduledTimer(
            withTimeInterval: 5.0,
            repeats: false,
            block: { [weak self] _ in
                let newData = DataService.mockData

                self?.data = .success(newData)
                handler(.success(newData))
            }
        )
    }
}

extension DataService {
    private static let mockData = Features(features: [])
}
