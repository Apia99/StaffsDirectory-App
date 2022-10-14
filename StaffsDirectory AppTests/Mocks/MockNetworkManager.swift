//
//  MockNetworkManager.swift
//  StaffsDirectoryTests
//
//  Created by Hafiz on 12/10/22.
//

import Foundation
@testable import StaffsDirectory_App

class MockNetworkManager: Servicable {
    
    func get<T>(_ baseUrl: String, path: String, type: T.Type, completionHandler: @escaping CompletionHandler<T>) where T : Decodable {
        let bundle = Bundle(for:MockNetworkManager.self)
        
        guard let url = bundle.url(forResource:path, withExtension:"json"),
              let data = try? Data(contentsOf: url) else {
            completionHandler(.failure(ServiceError.serviceNotAvailable))
            
            return
        }
        
        do {
            let decodedResopnce = try JSONDecoder().decode(T.self, from: data)
            completionHandler(.success(decodedResopnce))
            
        }catch {
            completionHandler(.failure(ServiceError.parsingFailed))
        }
    }
    func get(url: String, completion: @escaping (Data?) -> Void) {
        
    }
}

