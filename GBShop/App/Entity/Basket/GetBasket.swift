//
//  GetBasket.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 20.09.2021.
//

import Foundation

// MARK: - GetBasketResult
struct GetBasketResult: Codable {
    let amount, countGoods: Int
    let contents: [Content]
}

// MARK: - Content
struct Content: Codable {
    let idProduct: Int
    let productName: String
    let price, quantity: Int

    enum CodingKeys: String, CodingKey {
        case idProduct = "id_product"
        case productName = "product_name"
        case price, quantity
    }
}
