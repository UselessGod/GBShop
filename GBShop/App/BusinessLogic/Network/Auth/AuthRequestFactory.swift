//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 23.08.2021.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
}
