//
//  ServiceManager.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import Foundation

class ServiceManager: Servicable {
    let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    func get<T:Decodable>(_ baseUrl: String, path: String, type: T.Type, completionHandler: @escaping CompletionHandler<T>)
    {
        guard let url = URL(string:baseUrl.appending(path)) else {
            completionHandler(.failure(ServiceError.requestNotFormatted))
            return
        }
        let dataTask = urlSession.dataTask(with: url) { data, urlResponse, error in
            
            guard let _data = data else {
                completionHandler(.failure(ServiceError.serviceNotAvailable))
                return
            }
            do {
                let users =  try JSONDecoder().decode(T.self, from: _data)
                completionHandler(.success(users))
            }catch {
                completionHandler(.failure(ServiceError.parsingFailed))
            }
        }
        dataTask.resume()
    }
    
    func get(url: String, completion:@escaping(Data?)-> Void) {
        guard let _url = URL(string: url) else {
            return
        }
        URLSession.shared.dataTask(with: _url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil
                else { return }

              completion(data)
        }.resume()
    }
}
