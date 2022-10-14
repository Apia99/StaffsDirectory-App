//
//  EndPoint.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import Foundation

struct EndPoint {
    static var baseUrl: String {
        return   (Bundle.main.object(forInfoDictionaryKey: "base_url") as? String)?.replacingOccurrences(of: "\\", with: "") ?? ""
    }
}

struct Path {
    static let people = "people"
    static let rooms = "rooms"
}
