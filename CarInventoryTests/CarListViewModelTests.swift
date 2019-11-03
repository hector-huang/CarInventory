import XCTest

class CarListViewModelTests: XCTestCase {
    let testTimeout: TimeInterval = 1
    
    var viewModel: CarListViewModel!

    override func setUp() {
        // create mock URLSession
        setupMockData()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        let mockApi = ApiManager(session: session, user: "test", password: "password")
        viewModel = CarListViewModel(api: mockApi)
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
    
    // Test if the view model can get the data to put into the list
    func testNormalCarList() {
        viewModel.fetchList()
        let exp = expectation(description: "CarList request complete")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            exp.fulfill()
        }
        waitForExpectations(timeout: testTimeout) { _ in
            XCTAssertEqual(self.viewModel.dataSource.count, 2)
            XCTAssertEqual(self.viewModel.dataSource.first!.id, "AD-5989286")
            XCTAssertEqual(self.viewModel.dataSource[1].price, "$40,037")
        }
    }
    
    // Test if the view model can't get any data if passing wrong username or password
    // Also test the error state in the view model
    func testEmptyCarList() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        let mockApi = ApiManager(session: session, user: "test", password: "wrongpassword")
        viewModel = CarListViewModel(api: mockApi)
        let exp = expectation(description: "CarList request complete")
               DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                   exp.fulfill()
               }
               waitForExpectations(timeout: testTimeout) { _ in
                   XCTAssertTrue(self.viewModel.dataSource.isEmpty)
                XCTAssertNotNil(self.viewModel.error)
               }
    }
}
