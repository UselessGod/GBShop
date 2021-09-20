//
//  Basket.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 20.09.2021.
//

import Foundation
import Alamofire

class Basket: AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    lazy var baseUrl = URL(string: "http://127.0.0.1:8080/basket/")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue!
    }
}

extension Basket: BasketRequestFactory {
    func getBasket(userId: Int, completion: @escaping (AFDataResponse<GetBasketResult>) -> Void) {
        let requestModel = GetBasket(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completion)
    }
    
    func addProductToBasket(productId: Int, userId: Int, quantity: Int, completion: @escaping (AFDataResponse<AddToBasketResult>) -> Void) {
        let requestModel = AddToBasket(baseUrl: baseUrl, userId: userId,
                                           productId: productId, quantity: quantity)
        self.request(request: requestModel, completionHandler: completion)
    }
    
    func deleteFromBasket(productId: Int, userId: Int, completion: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void) {
        let requestModel = DeleteFromBasket(baseUrl: baseUrl, userId: userId, productId: productId)
        self.request(request: requestModel, completionHandler: completion)
    }
}

extension Basket {
    struct GetBasket: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "getBasket"
        
        let userId: Int
        var parameters: Parameters? {
            return [
                "userId": userId
            ]
        }
    }
    
    struct AddToBasket: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "addToBasket"
        
        let userId: Int
        let productId: Int
        let quantity: Int
        
        var parameters: Parameters? {
            return [
                "userId": userId,
                "productId": productId,
                "quantity": quantity
            ]
        }
    }
    
    struct DeleteFromBasket: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "deleteFromBasket"
        
        let userId: Int
        let productId: Int
        
        var parameters: Parameters? {
            return [
                "userId": userId,
                "productId": productId
            ]
        }
    }
}
