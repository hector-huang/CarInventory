import XCTest

/// This test is designed to test if UI elements are displayed as we expected.
/// For example, we can check the number of items in the list (tableview) after fully loading the car list from mock api.
/// However, until Apple designs testability into SwfitUI and expose this testability to us, we cannot test each element.

class CarInventoryTests: XCTestCase {
    var carlistView: CarListView!
    var carDetailsView: CarDetailsView!
    
    override func setUp() {
        setupMockData()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        let mockApi = ApiManager(session: session, user: "test", password: "password")
        
        carlistView = CarListView(viewModel: CarListViewModel(api: mockApi))
        carDetailsView = CarDetailsView(viewModel: CarDetailsViewModel(api: mockApi, carId: "AD-5889516"))
    }
    
    func testExample() {
        XCTAssertNotNil(carlistView.body)
        XCTAssertNotNil(carDetailsView.body)
    }
    
    private func setupMockData() {
        let carListRoute = CarRoute.list(user: "test", password: "password")
        var carListComponents = URLComponents()
        carListComponents.scheme = ApiManager.CarAPI.scheme
        carListComponents.host = ApiManager.CarAPI.host
        carListComponents.path = carListRoute.path
        carListComponents.queryItems = carListRoute.queryItems
        let carListUrl = carListComponents.url!
        URLProtocolMock.testUrls = [carListUrl: Data(MockData.carListResponse.utf8)]
        URLProtocolMock.response = MockData.validResponse
    }

}
