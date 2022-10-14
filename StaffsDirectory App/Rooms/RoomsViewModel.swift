//
//  RoomsViewModel.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import Foundation
import UIKit

protocol RoomsViewModelType {
    var roomsCount: Int {get}
    func fetchRooms(baseUrl: String, path: String)
    func getRoomFor(index: Int)-> Room?
}

class RoomsViewModel: RoomsViewModelType {

    private var rooms:[RoomsResponce] = []
    var roomsCount:Int {
        return rooms.count
    }
    
    private let serviceManager: Servicable
    var refreshView:(()-> ())?
    var showError:(()-> ())?
    init(serviceManager: Servicable = ServiceManager()) {
        self.serviceManager = serviceManager
    }
    func fetchRooms(baseUrl: String, path: String) {
        serviceManager.get(baseUrl, path: path, type: [RoomsResponce].self) {[weak self] result in
            
            switch result {
            case .success(let rooms) :
                self?.rooms = rooms
                self?.refreshView?()
            case .failure(_) :
                self?.rooms = []
                self?.showError?()
            }
        }
    }
    func getRoomFor(index: Int) -> Room? {
        guard index < roomsCount && index >= 0 else {
            return nil
        }
        let roomModel = rooms[index]
        let color:UIColor = roomModel.isOccupied ? .red : .green
        return Room(createdAt: roomModel.createdAt, occupiedMessage: roomModel.isOccupied ? "Occupied" : "Not Occupied", maxOccupancy: roomModel.maxOccupancy, id: roomModel.id,
                    color: color)
    }
}
