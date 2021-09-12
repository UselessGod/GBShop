//
//  RegisterTest.swift
//  GBShopTests
//
//  Created by Дмитрий Емельянов on 08.09.2021.
//

import XCTest
import Alamofire
@testable import GBShop

enum RegisterApiErrorStub: Error {
    case fatalError
}


struct REgisterErrorParserStub: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return RegisterApiErrorStub.fatalError
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}

class RegisterTest: XCTestCase {
    let exectation = XCTestExpectation(description: "RegisterTests")
    var errorParser: ErrorParseStub!
    let sessionManager = Session(configuration: URLSessionConfiguration.default)
    var register: Register!
   
    override func setUp() {
        errorParser = ErrorParseStub()
        register = Register.init(errorParser: errorParser, sessionManager: sessionManager)
    }
    
    override func tearDown() {
        register = nil
        errorParser = nil
    }
    
    func testRegister() {
       let user = UserResult(id: 123, email: "21", password: "12", newPassword: "12", firstName: "123", lastName: "q")
        register.register(user: user) { [weak self] (response: AFDataResponse<RegistrationResult>) in
            switch response.result {
            case .success(let registerResult):
                if registerResult.result != 1 {
                    XCTFail("Unknown registerResult")
                }
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            self?.exectation.fulfill()
        }
        
         wait(for: [exectation], timeout: 10.0)
    }
}
