//
//  Review.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 08.09.2021.
//

import Foundation

struct Review: Codable {
     let id: Int
     let productId: Int
     let userFullName, userEmail, title, description: String

     enum CodingKeys: String, CodingKey {
         case id = "id_review"
         case productId = "id_product"
         case userFullName = "user_name"
         case userEmail = "user_email"
         case title = "title"
         case description = "description"
     }
 }

typealias ReviewResult = [Review]
