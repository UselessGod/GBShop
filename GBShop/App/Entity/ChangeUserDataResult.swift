//
//  ChangeUserData.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 23.08.2021.
//

import Foundation

// MARK: - ChangeUserData
struct ChangeUserDataResult: Codable {
    var id_user: Int
    var username: String
    var password: String
    var email: String
    var gender: String
    var credit_card: String
    var bio: String
}
