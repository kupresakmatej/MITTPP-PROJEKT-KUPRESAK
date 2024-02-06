//
//  RootCoordinator.swift
//  Shows
//
//  Created by Matej Kuprešak on 27.09.2023..
//

import Foundation
import UIKit
import SwiftUI

final class BaseNavigationController: UINavigationController { }

final class RootCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    func start() -> UIViewController {
        return createTabBarController()
    }
    
    let serviceFactory: ServiceFactory
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    func createTabBarController() -> UIViewController {
        let tabBarController = UITabBarController()
        
        let homeCoordinator = HomeCoordinator(serviceFactory: serviceFactory)
        childCoordinators.append(homeCoordinator)
        let homeViewController = homeCoordinator.start()
        
        let searchCoordinator = SearchCoordinator(navigationController: BaseNavigationController(), serviceFactory: serviceFactory)
        childCoordinators.append(searchCoordinator)
        let searchViewController = searchCoordinator.start()
        
        let favoritesCoordinator = FavoritesCoordinator(navigationController: BaseNavigationController(), serviceFactory: serviceFactory)
        childCoordinators.append(favoritesCoordinator)
        let favoritesViewController = favoritesCoordinator.start()
        
        homeViewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house.fill"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        searchViewController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        favoritesViewController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "heart.fill"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = UIColor(Color.primaryDarkGray)
                
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color.primaryYellow)]
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.primaryYellow)
           
        tabBarController.tabBar.standardAppearance = tabBarAppearance
        tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
        
        tabBarController.viewControllers = [homeViewController, searchViewController, favoritesViewController]
        
        tabBarController.selectedIndex = 0
        
        return tabBarController
    }
}
