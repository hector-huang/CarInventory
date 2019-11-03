import Foundation
import Combine

protocol CarFetchable {
    func fetchCarList() -> AnyPublisher<CarListResponse, CarError>
    func fetchCarDetails(id: String) -> AnyPublisher<CarDetailsResponse, CarError>
}

class ApiManager: CarFetchable {
    private let session: URLSession
    private let user: String
    private let password: String
    
    static let shared = ApiManager()
    
    init(session: URLSession = .shared, user: String = "test", password: String = "2h7H53eXsQupXvkz") {
        self.session = session
        self.user = user
        self.password = password
    }
    
    func fetchCarList() -> AnyPublisher<CarListResponse, CarError> {
        return fetch(with: CarRoute.list(user: user, password: password))
    }
    
    func fetchCarDetails(id: String) -> AnyPublisher<CarDetailsResponse, CarError> {
        return fetch(with: CarRoute.details(id: id, user: user, password: password))
    }
}

extension ApiManager {
    struct CarAPI {
        static let scheme = "https"
        static let host = "buttered-pewter.glitch.me"
    }
    
    private func fetch<T>(with path: Path) -> AnyPublisher<T, CarError> where T: Decodable {
        var components = URLComponents()
        components.scheme = CarAPI.scheme
        components.host = CarAPI.host
        components.path = path.path
        components.queryItems = path.queryItems
        guard let url = components.url else {
            let error = CarError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .tryMap({ data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    // TODO: This will include all the error status such as authentication(401), authorisation(403) and bad request(400), which can be handled differently in the future
                    throw CarError.network(description: "Invalid server response")
                }
                return data
            })
            .mapError { error in
                if let error = error as? CarError {
                    return error
                } else {
                    return .network(description: error.localizedDescription)
                }
            }
            .flatMap(maxPublishers: .max(1)) { data in
                self.decode(data)
            }
            .eraseToAnyPublisher()
    }
    
    private func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, CarError> {
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .secondsSince1970

      return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
          .parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
}
