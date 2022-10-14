//
//  RoomsCoordinator.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import Foundation
import UIKit

final class RoomsCoordinator: CoordinatorType {
    var navController: UINavigationController
    private let sb = UIStoryboard(name: "Main", bundle:nil)

    init() {
        navController = UINavigationController()
    }
    func start() {
        let roomsVC = sb.instantiateViewController(withIdentifier:"RoomsViewer")
        navController.pushViewController(roomsVC, animated: false)
        
        let roomsTab = UITabBarItem(title: "Rooms", image: UIImage(systemName: "square.split.bottomrightquarter"), selectedImage: UIImage(named: "otherImage.png"))
        navController.tabBarItem = roomsTab
    }
}
