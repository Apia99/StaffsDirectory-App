//
//  APIManagerTests.swift
//  StaffsDirectory
//
//  Created by Hafiz on 11/10/22.
//

import XCTest
@testable import StaffsDirectory

class ServiceManagerTests: XCTestCase {

    var serviceManager: ServiceManager!
    var mockURLSession: MockURLSession!
    
    override func setUpWithError() throws {
        mockURLSession = MockURLSession()
        serviceManager = ServiceManager(urlSession: mockURLSession)
    }

    override func tearDownWithError() throws {
        serviceManager = nil
    }
    
    // Invalid Empty request URL
    func testFailedToCreateRequestForEmptyURL() {

        serviceManager.get("", path: "", type: [PeopleResponce].self, completionHandler: { result in
            switch result {
            case .success( _):
                break
            case .failure(let error):
                XCTAssertEqual(error, ServiceError.requestNotFormatted)
            }
        })
    }
    
    // Valid Response Code - 200 but data not valid , Parsing error
    func testWhenResponseCodeIsValidButDataIdNotAsPerModel() {

        // GIVEN
        let url = URL(string:"test")
        
        mockURLSession.enqueueResponse(data: "success".data(using: .utf8), urlResponse: HTTPURLResponse(url:url!, statusCode: 200, httpVersion: nil, headerFields: nil)!, error: nil)

        // WHEN
        
        serviceManager.get("test", path: "", type: [PeopleResponce].self, completionHandler: { result in

            switch result {
            case .success( _):
                break
            case .failure(let error):
                XCTAssertEqual(error, ServiceError.parsingFailed)
            }
        })
    }

    // Invalid Response Code (not in 200 to 299 range)
    func testWhenResponseCodeIsNotSuccess() {

        // GIVEN
        let url = URL(string:"test")
        
        mockURLSession.enqueueResponse(data: nil, urlResponse: HTTPURLResponse(url:url!, statusCode: 404, httpVersion: nil, headerFields: nil)!, error: nil)

        // WHEN
        
        serviceManager.get("test", path: "", type: [PeopleResponce].self, completionHandler: { result in

            switch result {
            case .success( _):
                break
            case .failure(let error):
                XCTAssertEqual(error,ServiceError.serviceNotAvailable)
            }
        })
    }

    // Valid Response Code - 200 and data is nil
    func testWhenResponseCodeIsValidButDataIsNil() {

        // GIVEN
        let url = URL(string:"test")
        
        mockURLSession.enqueueResponse(data: nil, urlResponse: HTTPURLResponse(url:url!, statusCode: 200, httpVersion: nil, headerFields: nil)!, error: nil)

        // WHEN
        
        serviceManager.get("test", path: "", type: [PeopleResponce].self, completionHandler: { result in

            switch result {
            case .success( _):
                break
            case .failure(let error):
                XCTAssertEqual(error, ServiceError.serviceNotAvailable)
            }
        })
    }
}

