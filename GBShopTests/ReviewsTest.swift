//
//  ReviewsTest.swift
//  GBShopTests
//
//  Created by Дмитрий Емельянов on 08.09.2021.
//

import XCTest
import Alamofire
@testable import GBShop

enum ReviewsApiErrorStub: Error {
    case fatalError
}

struct ReviewsErrorParserStub: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return ReviewsApiErrorStub.fatalError
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}

class ReviewsTest: XCTestCase {
    let exectation = XCTestExpectation(description: "ReviewsTests")
    var errorParser: ReviewsErrorParserStub!
    let sessionManager = Session(configuration: URLSessionConfiguration.default)
    var reviewObject: Reviews!
    
    override func setUp() {
        errorParser = ReviewsErrorParserStub()
        reviewObject = Reviews.init(errorParser: errorParser, sessionManager: sessionManager)
    }
    
    override func tearDown() {
        errorParser = nil
        reviewObject = nil
    }
    
    func testAddReview() {
        
        reviewObject.addReview(idUser: 1, text: "123") { [weak self] (response: AFDataResponse<AddReviewResult>) in
            switch response.result {
            case .success(let addResult):
                if addResult.result != 1 {
                    XCTFail("Something went wrong")
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.exectation.fulfill()
        }
        
        wait(for: [exectation], timeout: 10.0)
    }
    
    func testApproveReview() {
        reviewObject.approveReview(reviewId: 2) { [weak self] (response: AFDataResponse<ApproveReviewResult>) in
            switch response.result {
            case .success(let approveResult):
                if approveResult.result != 1 {
                    XCTFail("Something went wrong")
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            self?.exectation.fulfill()
        }
        
        wait(for: [exectation], timeout: 10.0)
    }
    
    func testRemoveReview() {
        reviewObject.removeReview(reviewId: 2) { [weak self] (respone: AFDataResponse<RemoveReviewResult>) in
            switch respone.result {
            case .success(let removeResult):
                if removeResult.result != 1 {
                    XCTFail("Something went wrong")
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            self?.exectation.fulfill()
        }
        
        wait(for: [exectation], timeout: 10.0)
    }
}
