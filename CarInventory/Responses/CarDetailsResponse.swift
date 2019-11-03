import Foundation

struct CarDetailsResponse: Decodable {
    let id: String
    let location: String
    let price: String
    let saleStatus: String
    let comments: String
    let photos: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case location = "Location"
        case price = "Price"
        case saleStatus = "SaleStatus"
        case comments = "Comments"
        case photos = "Photos"
        case overview = "Overview"
    }
    
    public init(from decoder: Decoder) throws {
        let carDetails = try decoder.container(keyedBy: CodingKeys.self)
        id = try carDetails.decode(String.self, forKey: .id)
        saleStatus = try carDetails.decode(String.self, forKey: .saleStatus)
        comments = try carDetails.decode(String.self, forKey: .comments)
        
        let overviewContainer = try carDetails.nestedContainer(keyedBy: CodingKeys.self, forKey: .overview)
        location = try overviewContainer.decode(String.self, forKey: .location)
        price = try overviewContainer.decode(String.self, forKey: .price)
        photos = try overviewContainer.decode([String].self, forKey: .photos)
    }
}
