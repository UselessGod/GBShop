//
//  ReviewRequestFactory.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 08.09.2021.
//

import Foundation
import Alamofire

protocol ReviewRequestFactory: AbstractRequestFactory{
    func addReview(idUser: Int, text: String, completion: @escaping (AFDataResponse<AddReviewResult>) -> Void)
    func approveReview(reviewId: Int, completion: @escaping (AFDataResponse<ApproveReviewResult>) -> Void)
    func removeReview(reviewId: Int, completion: @escaping (AFDataResponse<RemoveReviewResult>) -> Void)
}
