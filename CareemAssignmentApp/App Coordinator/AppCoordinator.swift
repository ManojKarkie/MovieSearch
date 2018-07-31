//
//  AppCoordinator.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/28/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import UIKit

// MARK:- Base Coordinator

class Coordinator {
    var childCoordinators = [Coordinator]()

    func addChildCoordinator(child: Coordinator) {
        childCoordinators.append(child)
    }

    func removeChildCoordinator(child: Coordinator) {
        childCoordinators =  childCoordinators.filter { $0 !== child }
    }

}

final class AppCoordinator: Coordinator {

    fileprivate weak var window: UIWindow?

    init(_ window: UIWindow?) {
        self.window = window
    }

    // MARK:- Start the flow of the app

    func start() {
        let movieSearchVc = MovieSearchViewController.initFromStoryboard(name: "MovieSearch")
        let nav = UINavigationController.init(rootViewController: movieSearchVc)
        nav.navigationBar.isTranslucent = false
        window?.rootViewController = nav
    }
}
