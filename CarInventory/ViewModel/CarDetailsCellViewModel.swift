import Foundation

struct CarDetailsCellViewModel: Identifiable {
    private let item: CarDetailsResponse
    
    var id: String {
        return item.id
    }
    
    var price: String {
        return item.price
    }
    
    var location: String {
        return item.location
    }
    
    var saleStatus: String {
        return item.saleStatus
    }
    
    var comments: String {
        return item.comments
    }
    
    var photoUrls: [URL?] {
        return item.photos.map { URL(string: $0) }
    }
    
    init(response: CarDetailsResponse) {
        self.item = response
    }
}

extension CarDetailsCellViewModel: Hashable {
    static func == (lhs: CarDetailsCellViewModel, rhs: CarDetailsCellViewModel) -> Bool {
      return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(self.id)
    }
}
