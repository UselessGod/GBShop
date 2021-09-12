//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Дмитрий Емельянов on 23.08.2021.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
