//
//  ServiceError.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import Foundation

enum ServiceError: Error {
    case serviceNotAvailable
    case parsingFailed
    case requestNotFormatted
}
