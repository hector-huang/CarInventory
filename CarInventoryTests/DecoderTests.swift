import XCTest

class DecoderTests: XCTestCase {
    var carListData: Data!
    var carDetailsData: Data!
        
    override func setUp() {
        let carListDict = ["Result":[["Id":"AD-5989286","Title":"2019 Mitsubishi Triton GLS MR Auto 4x4 MY19 Double Cab","Location":"Victoria","Price":"$53,081","MainPhoto":"https://carsales.li.csnstatic.com/car/cil/x5u9lqi56jdcs430bud8n767c.jpg","DetailsUrl":"/details/AD-5989286"],["Id":"AD-5922149","Title":"2019 Subaru Forester 2.5i-L S5 Auto AWD MY19","Location":"NSW","Price":"$40,037","MainPhoto":"https://carsales.li.csnstatic.com/car/cil/gqgf9d05uk2rcwqocniamg8ge.jpg","DetailsUrl":"/details/AD-5922149"]]] as [String : Any?]
        do {
            carListData = try JSONSerialization.data(withJSONObject:carListDict)
        } catch {}
        
        let carDetailsDict = ["Id":"AD-5889516","SaleStatus":"Avaliable","Comments":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliter homines, aliter philosophos loqui putas oportere? Omnes enim iucundum motum, quo sensus hilaretur.","Overview":["Location":"Victoria","Price":"$53,081","Photos":["https://carsales.li.csnstatic.com/car/cil/x5u9lqi56jdcs430bud8n767c.jpg","https://carsales.li.csnstatic.com/car/cil/ikdxyxcar2vu0il5h4ue5bz38.jpg"]]] as [String: Any?]
        do {
            carDetailsData = try JSONSerialization.data(withJSONObject: carDetailsDict)
        } catch {}
    }

    func testCarListDecoder() {
        let decoder = JSONDecoder()
        let carList = try! decoder.decode(CarListResponse.self, from: carListData)
        XCTAssertEqual(carList.cars.first!.id, "AD-5989286")
        XCTAssertEqual(carList.cars.first!.title, "2019 Mitsubishi Triton GLS MR Auto 4x4 MY19 Double Cab")
        XCTAssertEqual(carList.cars.first!.detailsUrl, "/details/AD-5989286")
        XCTAssertEqual(carList.cars[1].location, "NSW")
        XCTAssertEqual(carList.cars[1].price, "$40,037")
        XCTAssertEqual(carList.cars[1].mainPhoto, "https://carsales.li.csnstatic.com/car/cil/gqgf9d05uk2rcwqocniamg8ge.jpg")
    }

    func testCarDetailsDecoder() {
        let decoder = JSONDecoder()
        let carDetails = try! decoder.decode(CarDetailsResponse.self, from: carDetailsData)
        XCTAssertEqual(carDetails.id, "AD-5889516")
        XCTAssertEqual(carDetails.saleStatus, "Avaliable")
        XCTAssertTrue(carDetails.comments.contains("ipiscing elit. Aliter homines, a"))
        XCTAssertEqual(carDetails.location, "Victoria")
        XCTAssertEqual(carDetails.price, "$53,081")
        XCTAssertEqual(carDetails.photos.first!, "https://carsales.li.csnstatic.com/car/cil/x5u9lqi56jdcs430bud8n767c.jpg")
    }

}
