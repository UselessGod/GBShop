//
//  BasketTest.swift
//  GBShopTests
//
//  Created by Дмитрий Емельянов on 20.09.2021.
//

import XCTest
import Alamofire
@testable import GBShop

enum BasketApiErrorStub: Error {
    case fatalError
}

struct BasketErrorParserStub: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return BasketApiErrorStub.fatalError
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}

class BasketTest: XCTestCase {

    let expecation = XCTestExpectation(description: "BasketTest")
    var errorParser: BasketErrorParserStub!
    let sessionManager = Session(configuration: URLSessionConfiguration.default)
    var basketObject: Basket!
    var timeout: TimeInterval = 10.0
    
    override func setUp() {
        errorParser = BasketErrorParserStub()
        basketObject = Basket.init(errorParser: errorParser, sessionManager: sessionManager)
    }
    
    override func tearDown() {
        errorParser = nil
        basketObject = nil
    }
    
    func testGetBasket() {
        basketObject.getBasket(userId: 1) { [weak self] (response: AFDataResponse<GetBasketResult>) in
            switch response.result {
            case .success(_):
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.expecation.fulfill()
        }
        
        wait(for: [expecation], timeout: timeout)
    }
    
    func testAddToBasket() {
        basketObject.addProductToBasket(productId: 1, userId: 1, quantity: 1) { [weak self] (response: AFDataResponse<AddToBasketResult>) in
            switch response.result {
            case .success(let addToBasket):
                if addToBasket.result != 1 {
                    XCTFail("Fail add to basket")
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.expecation.fulfill()
        }
        
        wait(for: [expecation], timeout: timeout)
    }
    
    func testRemoveFromBasket() {
        basketObject.deleteFromBasket(productId: 1, userId: 1) { [weak self] (response: AFDataResponse<DeleteFromBasketResult>) in
            switch response.result {
            case .success(let removeFromBasket):
                if removeFromBasket.result != 1 {
                    XCTFail("Fail to remove from basket")
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.expecation.fulfill()
        }
        
        wait(for: [expecation], timeout: timeout)
    }

}
