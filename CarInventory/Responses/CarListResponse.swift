import Foundation

struct CarListResponse: Decodable {
    let cars: [CarResponse]
    
    enum CodingKeys: String, CodingKey {
        case cars = "Result"
    }
}

struct CarResponse: Decodable {
    let id: String
    let title: String
    let location: String
    let price: String
    let mainPhoto: String
    let detailsUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case location = "Location"
        case price = "Price"
        case mainPhoto = "MainPhoto"
        case detailsUrl = "DetailsUrl"
    }
}
