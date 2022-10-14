//
//  CoordinatorType.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import Foundation
import UIKit

protocol CoordinatorType: AnyObject {
    var navController: UINavigationController { get set }
    func start()
}
