//
//  Login.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 23.08.2021.
//

import Foundation

// MARK: - Login
struct LoginResult: Codable {
    let result: Int
    let user: User
    let authToken: String
}

// MARK: - User
struct User: Codable {
    let idUser: Int
    let userLogin, userName, userLastname: String

    enum CodingKeys: String, CodingKey {
        case idUser = "id_user"
        case userLogin = "user_login"
        case userName = "user_name"
        case userLastname = "user_lastname"
    }
}
