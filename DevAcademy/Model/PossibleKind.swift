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
