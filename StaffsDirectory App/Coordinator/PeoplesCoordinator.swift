//
//  PeoplesCoordinator.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import Foundation
import UIKit

protocol PeoplesCoordinatoryType: AnyObject {
    func navigatToPeopleDetails(people: People)
}

final class PeoplesCoordinator: CoordinatorType, PeoplesCoordinatoryType {
    var navController: UINavigationController
    private let sb = UIStoryboard(name: "Main", bundle:nil)

    init() {
        navController = UINavigationController()
    }
    func start() {
        guard let peopleVC = sb.instantiateViewController(withIdentifier:"StaffViewer") as? PeoplesViewController else  {
            return
        }
        peopleVC.peopleViewModel  =     PeoplesViewModel()
        peopleVC.coordinator = self
        navController.pushViewController(peopleVC, animated: false)
        let peoplesTab = UITabBarItem(title: "People", image: UIImage(systemName: "plus.rectangle.on.folder"), selectedImage: UIImage(named: "otherImage.png"))
        navController.tabBarItem = peoplesTab
    }
    
    func navigatToPeopleDetails(people: People) {
        guard  let peopleDetailsVC = sb.instantiateViewController(withIdentifier:"PeoplesDetailsViewController") as? PeopleDetailsViewController else {
            return
        }
        peopleDetailsVC.viewModel  =     PeopleDetailsViewModel(people: people)
        navController.pushViewController(peopleDetailsVC, animated: false)
    }
}
