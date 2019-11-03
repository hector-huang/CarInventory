import Foundation

enum CarRoute: Path {
    /// example: https://buttered-pewter.glitch.me/stock/car/test/v1/listing?username=test&password=2h7H53eXsQupXvkz
    case list(user: String, password: String)
    /// example: https://buttered-pewter.glitch.me/details/AD-5979131?username=test&password=2h7H53eXsQupXvkz
    case details(id: String, user: String, password: String)
}

extension CarRoute {
    var path: String {
        switch self {
        case .list:
            return "/stock/car/test/v1/listing"
        case .details(let id, _, _):
            return "/details/\(id)"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .list(let user, let password):
            return [.init(name: "username", value: user), .init(name: "password", value: password)]
        case .details(_, let user, let password):
            return [.init(name: "username", value: user), .init(name: "password", value: password)]
        }
    }
}
