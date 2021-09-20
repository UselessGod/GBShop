//
//  Register.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 31.08.2021.
//

import Foundation
import Alamofire

class Register: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "http://127.0.0.1:8080/register/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Register: RegisterAndUpdateFactory {
    func updateUserData(user data: UserResult, completion: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
        guard let userId = data.id else { return }
        let requestModel = UpdateUserData(baseUrl: baseUrl,
                                    userId: userId,
                                    email: data.email,
                                    password: data.password ?? "",
                                    newPassword: data.newPassword ?? "",
                                    firstName: data.firstName,
                                    lastName: data.lastName)
        
        self.request(request: requestModel, completionHandler: completion)
    }
    
    func register(user data: UserResult, completion: @escaping (AFDataResponse<RegistrationResult>) -> Void) {
        let requestModel = Register(baseUrl: baseUrl,
                                    email: data.email,
                                    password: data.password ?? "",
                                    firstName: data.firstName,
                                    lastName: data.lastName ?? "")
        
        self.request(request: requestModel, completionHandler: completion)
    }
}

extension Register {
    struct UpdateUserData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "change"
        
        let userId: Int
        let email: String
        let password: String
        let newPassword: String
        let firstName: String
        let lastName: String?
        
        var parameters: Parameters? {
            return [
                "userId": userId,
                "email": email,
                "password": password,
                "newPassword": newPassword,
                "firstName": firstName,
                "lastName": lastName ?? ""
            ]
        }
    }
    
    struct Register: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "register"
        
        let email: String
        let password: String
        let firstName: String
        let lastName: String?
        
        var parameters: Parameters? {
            return [
                "email": email,
                "password": password,
                "firstName": firstName,
                "lastName": lastName ?? ""
            ]
        }
    }

}
