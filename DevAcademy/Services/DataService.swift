import Foundation

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
            withTimeInterval: 3.0,
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
    private static let mockData = Features.mock
}
