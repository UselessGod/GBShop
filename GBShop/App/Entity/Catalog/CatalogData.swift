//
//  CatalogData.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 30.08.2021.
//

import Foundation

// MARK: - CatalogDatum
struct GetCatalogData: Codable {
    let idProduct: Int
    let productName: String
    let price: Int

    enum CodingKeys: String, CodingKey {
        case idProduct = "id_product"
        case productName = "product_name"
        case price
    }
}

typealias GetCatalog = [GetCatalogData]

