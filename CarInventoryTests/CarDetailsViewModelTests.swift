import XCTest

class CarDetailsViewModelTests: XCTestCase {
    let testTimeout: TimeInterval = 1
       
    var viewModel: CarDetailsViewModel!

    override func setUp() {
       // create mock URLSession
       setupMockData()
       let config = URLSessionConfiguration.ephemeral
       config.protocolClasses = [URLProtocolMock.self]
       let session = URLSession(configuration: config)
       let mockApi = ApiManager(session: session, user: "test", password: "password")
       viewModel = CarDetailsViewModel(api: mockApi, carId: "AD-5889516")
    }
    
    private func setupMockData() {
        let carDetailsRoute = CarRoute.details(id: "AD-5889516", user: "test", password: "password")
        var carListComponents = URLComponents()
        carListComponents.scheme = ApiManager.CarAPI.scheme
        carListComponents.host = ApiManager.CarAPI.host
        carListComponents.path = carDetailsRoute.path
        carListComponents.queryItems = carDetailsRoute.queryItems
        let carDetailsUrl = carListComponents.url!
        URLProtocolMock.testUrls = [carDetailsUrl: Data(MockData.carDetailResponse.utf8)]
        URLProtocolMock.response = MockData.validResponse
    }
    
    // Test if the view model can get the data to put into the details view
    func testNormalCarDetails() {
        viewModel.refresh()
        let exp = expectation(description: "CarDetails request complete")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            exp.fulfill()
        }
        waitForExpectations(timeout: testTimeout) { _ in
            XCTAssertEqual(self.viewModel.dataSource?.id, "AD-5889516")
            XCTAssertEqual(self.viewModel.dataSource?.saleStatus, "Avaliable")
            XCTAssertTrue(self.viewModel.dataSource?.comments.contains("orem ipsum dolor sit") ?? false)
            XCTAssertEqual(self.viewModel.dataSource?.location, "Victoria")
            XCTAssertEqual(self.viewModel.dataSource?.price, "$53,081")
            XCTAssertTrue(self.viewModel.dataSource?.photoUrls.contains(URL(string: "https://carsales.li.csnstatic.com/car/cil/x5u9lqi56jdcs430bud8n767c.jpg")) ?? false)
        }
    }
    
    // Test if the view model can't get any data if passing wrong carId
    func testEmptyCarList() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        let mockApi = ApiManager(session: session, user: "test", password: "password")
        viewModel = CarDetailsViewModel(api: mockApi, carId: "INVALIDID")
        let exp = expectation(description: "CarDetails request complete")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            exp.fulfill()
        }
        waitForExpectations(timeout: testTimeout) { _ in
            XCTAssertNil(self.viewModel.dataSource)
        }
    }
}
