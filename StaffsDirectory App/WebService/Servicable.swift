//
//  Servicable.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import Foundation

typealias CompletionHandler<T> = (Result<T,   ServiceError>)->Void

protocol Servicable {
    func get<T:Decodable>(_ baseUrl: String, path: String, type: T.Type, completionHandler: @escaping CompletionHandler<T>)
    func get(url: String, completion:@escaping(Data?)-> Void)
}
