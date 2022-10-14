//
//  MockURLSession.swift
//  StaffsDirectory
//
//  Created by Hafiz on 11/10/22.
//

import Foundation
@testable import StaffsDirectory

class MockURLSession: URLSession {
    
    let mockDataTask =  MockURLSessionDataTask()
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        mockDataTask.completionHandler = completionHandler
        return mockDataTask
    }
  
    func enqueueResponse(data: Data?, urlResponse: HTTPURLResponse, error: ServiceError?) {
        mockDataTask.data = data
        mockDataTask.urlResponse = urlResponse
        mockDataTask.serviceError = error
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    var  urlResponse: HTTPURLResponse!
    var  serviceError: ServiceError!
    var  data: Data?
    override func resume() {
        completionHandler!(data, urlResponse, serviceError)
    }
}
