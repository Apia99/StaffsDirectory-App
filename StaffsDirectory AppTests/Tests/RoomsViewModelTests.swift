//
//  RoomsViewModelTests.swift
//  StaffsDirectoryTests
//
//  Created by Hafiz on 12/10/22.
//

import XCTest
@testable import StaffsDirectory_App

class RoomsViewModelTests: XCTestCase {

    var roomViewModel: RoomsViewModel!
    
    override func setUpWithError() throws {
        let mockNetworkMaanger = MockNetworkManager()
        roomViewModel = RoomsViewModel(serviceManager: mockNetworkMaanger)
    }
    override func tearDownWithError() throws {
        roomViewModel = nil
    }

    func testFetchRooms_success() {
        roomViewModel.fetchRooms(baseUrl: "", path: "rooms_success_response")
         
        XCTAssertEqual(roomViewModel.roomsCount , 65)
    }
    
    func testFetchStaff_failure() {
        
        roomViewModel.fetchRooms(baseUrl: "", path: "failure_response")

        XCTAssertEqual(roomViewModel.roomsCount , 0)
    }

    func testGetStaff() {
        
        var room = roomViewModel.getRoomFor(index: 2)
        
        XCTAssertNil(room)
        
        room = roomViewModel.getRoomFor(index: -1)
        
        XCTAssertNil(room)
        
        roomViewModel.fetchRooms(baseUrl: "", path: "rooms_success_response")

        room = roomViewModel.getRoomFor(index: 0)
       
        XCTAssertNotNil(room)
        
        XCTAssertEqual(room!.occupiedMessage, "Not Occupied")
    }
}
