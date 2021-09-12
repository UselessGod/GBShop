//
//  AuthTest.swift
//  GBShopTests
//
//  Created by Дмитрий Емельянов on 30.08.2021.
//

import XCTest
import Alamofire
@testable import GBShop

enum AuthApiErrorStub: Error {
    case fatalError
}

struct ErrorParserStub: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return AuthApiErrorStub.fatalError
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}

class AuthTest: XCTestCase {

    let expectation = XCTestExpectation(description: "AuthTest")
    var errorParser: ErrorParserStub!
    let sessionManager = Session(configuration: URLSessionConfiguration.default)
    var auth: Auth!
    
    override func setUp() {
        errorParser = ErrorParserStub()
        auth = Auth(errorParser: errorParser, sessionManager: sessionManager)
    }
    
    override func tearDown() {
        super.tearDown()
        auth = nil
        errorParser = nil
    }
    
    func testLogin(){
        auth.login(userName: "Somebody", password: "RandomPassword"){ [weak self] (response: AFDataResponse<LoginResult>) in
            switch response.result {
            case .success(let loginResult):
                if loginResult.authToken.isEmpty {
                    XCTFail("Authtoken is empty")
                }
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.expectation.fulfill()
    }
    wait(for: [expectation], timeout: 10.0)
    }
    
}
