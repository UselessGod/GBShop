//
//  Reviews.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 08.09.2021.
//

import Foundation
import Alamofire

class Reviews: AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    var baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Reviews: ReviewRequestFactory {
    func addReview(idUser: Int, text: String, completion: @escaping (AFDataResponse<AddReviewResult>) -> Void) {
        let requestModel = ReviewDataAdd(baseUrl: baseUrl,
                                         idUser: idUser,
                                         text: "124")
        self.request(request: requestModel, completionHandler: completion)
    }
    
    func approveReview(reviewId: Int, completion: @escaping (AFDataResponse<ApproveReviewResult>) -> Void) {
        let requestModel = ReviewDataApprove(baseUrl: baseUrl, reviewId: reviewId)
        self.request(request: requestModel, completionHandler: completion)
    }
    
    func removeReview(reviewId: Int, completion: @escaping (AFDataResponse<RemoveReviewResult>) -> Void) {
        let requestModel = ReviewDataRemove(baseUrl: baseUrl, reviewId: reviewId)
        self.request(request: requestModel, completionHandler: completion)
    }

}

extension Reviews {
    struct ReviewData: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "list"
        
        let productId: Int
        var parameters: Parameters? {
            return [
                "id_product": productId
            ]
        }
    }
    
    struct ReviewDataAdd: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "addReview.json"
        
        let idUser: Int
        let text: String
        
        var parameters: Parameters? {
            return [
                "id_user": idUser,
                "text": text
            ]
        }
    }
    
    struct ReviewDataApprove: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "approveReview.json"
        
        let reviewId: Int
        
        var parameters: Parameters? {
            return [
                "id_review": reviewId
            ]
        }
    }
    
    struct ReviewDataRemove: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "removeReview.json"
        
        let reviewId: Int
        
        var parameters: Parameters? {
            return [
                "id_review": reviewId
            ]
        }
    }
}
