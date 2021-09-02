//
//  GetGoodById.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 30.08.2021.
//

import Foundation

// MARK: - GetGoodByID
struct GetGoodByID: Codable {
    let result: Int
    let productName: String
    let productPrice: Int
    let productDescription: String

    enum CodingKeys: String, CodingKey {
        case result
        case productName = "product_name"
        case productPrice = "product_price"
        case productDescription = "product_description"
    }
}
