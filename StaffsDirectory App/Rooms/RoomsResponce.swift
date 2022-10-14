//
//  RoomsResponce.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import Foundation

struct RoomsResponce: Decodable {
    var createdAt: String
    var isOccupied: Bool
    var maxOccupancy: Int
    var id: String
}
