//
//  UserResult.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 31.08.2021.
//

import Foundation

struct UserResult {
    let id: Int?
    let email: String
    let password, newPassword: String?
    let firstName: String
    let lastName: String?
    var fullName: String { firstName + " " + lastName!}
}
