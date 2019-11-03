import Foundation

struct MockData {
    static let carListResponse = """
    {"Result":[{"Id":"AD-5989286","Title":"2019 Mitsubishi Triton GLS MR Auto 4x4 MY19 Double Cab","Location":"Victoria","Price":"$53,081","MainPhoto":"https://carsales.li.csnstatic.com/car/cil/x5u9lqi56jdcs430bud8n767c.jpg","DetailsUrl":"/details/AD-5989286"},{"Id":"AD-5922149","Title":"2019 Subaru Forester 2.5i-L S5 Auto AWD MY19","Location":"NSW","Price":"$40,037","MainPhoto":"https://carsales.li.csnstatic.com/car/cil/gqgf9d05uk2rcwqocniamg8ge.jpg","DetailsUrl":"/details/AD-5922149"}]}
    """
    
    static let carDetailResponse = """
    {"Id":"AD-5889516","SaleStatus":"Avaliable","Comments":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliter homines, aliter philosophos loqui putas oportere? Omnes enim iucundum motum, quo sensus hilaretur.","Overview":{"Location":"Victoria","Price":"$53,081","Photos":["https://carsales.li.csnstatic.com/car/cil/x5u9lqi56jdcs430bud8n767c.jpg","https://carsales.li.csnstatic.com/car/cil/ikdxyxcar2vu0il5h4ue5bz38.jpg"]}}
    """
    
    static let invalidResponse = URLResponse(url: URL(string: "http://localhost:8080")!,
                                            mimeType: nil,
                                            expectedContentLength: 0,
                                            textEncodingName: nil)
    static let validResponse = HTTPURLResponse(url: URL(string: "http://localhost:8080")!,
                                                    statusCode: 200,
                                                    httpVersion: nil,
                                                    headerFields: nil)
}
