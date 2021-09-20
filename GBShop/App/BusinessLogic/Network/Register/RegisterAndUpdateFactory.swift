//
//  RegisterAndUpdateFactory.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 31.08.2021.
//

import Foundation
import Alamofire

protocol RegisterAndUpdateFactory{
    func updateUserData(user data: UserResult, completion: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)
    func register(user data: UserResult, completion: @escaping (AFDataResponse<RegistrationResult>) -> Void)
}
