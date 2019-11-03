import UIKit
import Combine

class CarListViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var dataSource: [CarCellViewModel] = []
    @Published var error: CarError? = nil
    
    private let api: ApiManager
    
    private var disposables = Set<AnyCancellable>()
    
    init(api: ApiManager = .shared) {
        self.api = api
        fetchList()
    }
    
    func fetchList() {
        self.loading = true
        api.fetchCarList()
        .map { response in
            response.cars.map(CarCellViewModel.init)
        }
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                self.loading = false
                switch value {
                case .failure(let error):
                    self.error = error
                    self.dataSource = []
                case .finished:
                    self.error = nil
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
