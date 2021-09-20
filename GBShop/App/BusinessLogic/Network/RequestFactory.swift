//
//  RequestFactory.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 23.08.2021.
//

import Foundation
import Alamofire

class RequestFactory {
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager

    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFatory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeGoodsFactory() -> GoodsRequesFactory {
        let errorParser = makeErrorParser()
        return Goods(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeRegisterFactory() -> RegisterAndUpdateFactory {
        let errorParser = makeErrorParser()
        return Register(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeReviewFactory() -> ReviewRequestFactory {
        let errorParser = makeErrorParser()
        return Reviews(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeBasketFactory() -> BasketRequestFactory {
        let errorParser = makeErrorParser()
        return Basket(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}

