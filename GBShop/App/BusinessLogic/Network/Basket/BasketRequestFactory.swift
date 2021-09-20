//
//  BasketRequestFactory.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 20.09.2021.
//

import Foundation
import Alamofire

protocol BasketRequestFactory: AbstractRequestFactory {
    func getBasket(userId: Int, completion: @escaping (AFDataResponse<GetBasketResult>) -> Void)
    
    func addProductToBasket(productId: Int, userId: Int,
                              quantity: Int, completion: @escaping (AFDataResponse<AddToBasketResult>) -> Void)
    
    func deleteFromBasket(productId: Int, userId: Int, completion: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void)
}
