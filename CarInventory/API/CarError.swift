import Foundation

enum CarError: Error {
    case parsing(description: String)
    case network(description: String)
    
    var localizedDescription: String {
        switch self {
        case .parsing(let description):
            return "Json parsing failed: \(description)"
        case .network(let description):
            return "Request failed: \(description)"
        }
    }
}
