import Foundation

struct CarCellViewModel: Identifiable {
    private let item: CarResponse
    
    var id: String {
        return item.id
    }
    
    var title: String {
        return item.title
    }
    
    var price: String {
        return item.price
    }
    
    var location: String {
        return item.location
    }
    
    var mainPhotoUrl: URL? {
        return URL(string: item.mainPhoto)
    }
    
    init(response: CarResponse) {
        self.item = response
    }
}

extension CarCellViewModel: Hashable {
    static func == (lhs: CarCellViewModel, rhs: CarCellViewModel) -> Bool {
      return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(self.id)
    }
}
