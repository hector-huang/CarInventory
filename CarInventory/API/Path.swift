import Foundation

public protocol Path {
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}
