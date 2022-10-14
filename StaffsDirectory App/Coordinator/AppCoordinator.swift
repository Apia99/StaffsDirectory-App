//
//  AppCoordinator.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import Foundation
import UIKit

protocol Coordinator {
    func start(window: UIWindow)
}

final class AppCoordinator: Coordinator {
    private var tabBarController: UITabBarController?
    private var peoplesCoordinator:PeoplesCoordinator?
    private var roomssCoordinator:RoomsCoordinator?
    
    func start(window: UIWindow) {
        guard let peopleTabFlow = createPeoplesFlow() else{ return }
        guard let roomsTabFlow = createRoomsTab() else{ return }
        tabBarController = UITabBarController()
        tabBarController?.viewControllers = [peopleTabFlow, roomsTabFlow]
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    private func createPeoplesFlow()-> UINavigationController? {
        peoplesCoordinator = PeoplesCoordinator()
        peoplesCoordinator?.start()
        return peoplesCoordinator?.navController
    }
    private func createRoomsTab()-> UINavigationController? {
        roomssCoordinator = RoomsCoordinator()
        roomssCoordinator?.start()
        return roomssCoordinator?.navController
    }
}
