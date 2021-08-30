//
//  GoodsRequestFactory.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 30.08.2021.
//

import Foundation
import Alamofire

protocol GoodsRequesFactory: AbstractRequestFactory {
    func getCatalog(completion: @escaping (AFDataResponse<GetCatalog>) -> Void)
    func getGoodById(productId: Int, completion: @escaping (AFDataResponse<GetCatalogData>) -> Void)
}
