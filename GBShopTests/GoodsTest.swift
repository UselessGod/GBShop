//
//  GoodsTest.swift
//  GBShopTests
//
//  Created by Дмитрий Емельянов on 30.08.2021.
//

import XCTest
import Alamofire
@testable import GBShop

enum GoodsApiErrorStub: Error {
    case fatalError
}

struct GoodsErrorParserStub: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return GoodsApiErrorStub.fatalError
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}

class GoodsTest: XCTestCase {

    let expectation = XCTestExpectation(description: "GoodsTest")
    var errorParser: GoodsErrorParserStub!
    let sessionManager = Session(configuration: URLSessionConfiguration.default)
    var goods: Goods!
    
    override func setUp() {
        super.setUp()
        errorParser = GoodsErrorParserStub()
        goods = Goods(errorParser: errorParser, sessionManager: sessionManager)
    }
    
    override func tearDown() {
        super.tearDown()
        errorParser = nil
        goods = nil
    }
   
    func testCatalogData() {
        goods.getCatalog() { [weak self] (response: AFDataResponse<GetCatalog>) in
            
            switch response.result {
            case .success(let productResult):
                if productResult.isEmpty {
                    XCTFail("No catalog return")
                }
                break
            case .failure(let error):
                XCTFail(error.localizedDescription.description)
            }
            
            self?.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
//    func testGoodById() {
//        goods.getGoodById (productId: 1) { [weak self] (response: AFDataResponse<GetGoodByID>) in
//            switch response.result {
//            case .success(let goodResult):
//                if goodResult.productDescription.isEmpty {
//                    XCTFail("Good not found")
//                }
//                break
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//            }
//            
//            self?.expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 10.0)
//    }
    
}
