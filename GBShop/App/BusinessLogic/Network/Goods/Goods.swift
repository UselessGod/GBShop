//
//  Goods.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 30.08.2021.
//

import Foundation
import Alamofire

class Goods: AbstractRequestFactory{
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    var baseUrl = URL(string: "http://127.0.0.1:8080/goods/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Goods: GoodsRequesFactory{
    
    func getCatalog(completion: @escaping (AFDataResponse<GetCatalog>) -> Void) {
        let requestModel = CatalogData(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completion)
    }
    
    func getGoodById(productId: Int, completion: @escaping (AFDataResponse<GetCatalogData>) -> Void) {
        let requestModel = GoodById(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completion)
    }
}

extension Goods {
    struct CatalogData: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "catalogData.json"
        var parameters: Parameters?
    }
    
    struct GoodById: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "getBasket.json"
        
        let productId: Int
        var parameters: Parameters? {
            return [
                "id": productId
            ]
        }
    }
}
