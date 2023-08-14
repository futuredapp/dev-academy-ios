import Foundation

struct Properties: Decodable {
    var ogcFid: Int
    var imageUrl: URL?
    var type: PossibleKind
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case ogcFid = "ogc_fid"
        case imageUrl = "obr_id1"
        case type = "druh"
        case name = "nazev"
    }
}
