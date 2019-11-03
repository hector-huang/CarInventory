import UIKit
import Combine

class CarDetailsViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var dataSource: CarDetailsCellViewModel? = nil
    
    private let api: ApiManager
    private let id: String
    
    // this serves the same role as disposebag in RxSwift for memory management
    private var disposables = Set<AnyCancellable>()
    
    init(api: ApiManager = .shared, carId: String) {
        self.api = api
        self.id = carId
    }
    
    func refresh() {
        self.loading = true
        api.fetchCarDetails(id: id)
            .map { response in
                CarDetailsCellViewModel(response: response)
            }
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                self.loading = false
                switch value {
                case .failure:
                    self.dataSource = nil
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] carRows in
                guard let self = self else { return }
                self.dataSource = carRows
        })
        .store(in: &disposables)
    }
}
