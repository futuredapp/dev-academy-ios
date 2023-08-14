import Foundation

enum APIError: Error {
    case invalidData
    case invalidResponse
    case decodingError(Error)
}

protocol PlacesService {
    func places(_ completion: @escaping (Result<Places, Error>) -> Void)
    func placesWithCheckedContinuation() async -> Result<Places, Error>
    func placesWithAsync() async throws -> Places
}

final class ProductionPlacesService: PlacesService {
    func places(_ completion: @escaping (Result<Places, Error>) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "https://gis.brno.cz/ags1/rest/services/OMI/omi_ok_kulturni_instituce/FeatureServer/0/query?where=1%3D1&outFields=*&f=json")!)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            do {
                let places = try JSONDecoder().decode(Places.self, from: data)
                completion(.success(places))
            } catch {
                completion(.failure(APIError.decodingError(error)))
            }
        }
        task.resume()
    }

    func placesWithCheckedContinuation() async -> Result<Places, Error> {
        await withCheckedContinuation { continuation in
            places { result in
                continuation.resume(returning: result)
            }
        }
    }

    func placesWithAsync() async throws -> Places {
        let session = URLSession.shared
        let (data, _) = try await session.data(from: URL(string: "https://gis.brno.cz/ags1/rest/services/OMI/omi_ok_kulturni_instituce/FeatureServer/0/query?where=1%3D1&outFields=*&f=json")!)
        return try JSONDecoder().decode(Places.self, from: data)
    }
}

final class MockPlacesService: PlacesService {
    func placesWithCheckedContinuation() async -> Result<Places, Error> {
        await withCheckedContinuation { continuation in
            places { result in
                continuation.resume(returning: result)
            }
        }
    }

    func placesWithAsync() async -> Places {
        Places.mock
    }

    
    func places(_ completion: @escaping (Result<Places, Error>) -> Void) {
        Timer.scheduledTimer(
            withTimeInterval: 3.0,
            repeats: false,
            block: { _ in
                let newData = Places.mock
                completion(.success(newData))
            }
        )
    }
}
