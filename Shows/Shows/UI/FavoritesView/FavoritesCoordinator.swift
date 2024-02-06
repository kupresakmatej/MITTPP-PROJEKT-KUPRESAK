//
//  FavoritesCoordinator.swift
//  Shows
//
//  Created by Matej Kuprešak on 27.09.2023..
//

import Foundation
import UIKit
import SwiftUI

final class FavoritesCoordinator: Coordinator {
    private var navigationController: BaseNavigationController
    let serviceFactory: ServiceFactory
    
    init(navigationController: BaseNavigationController, serviceFactory: ServiceFactory) {
        self.navigationController = navigationController
        self.serviceFactory = serviceFactory
    }
    
    func start() -> UIViewController {
        return createFavoritesViewController()
    }
    
    private func createFavoritesViewController() -> UIViewController {
        let vm = FavoritesViewModel(favoriteService: serviceFactory.favoriteService)
        let favoritesView = FavoritesView(viewModel: vm)
        let vc = UIHostingController(rootView: favoritesView)
        vc.title = ""
        
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().tintColor = .white
        
        vm.onShowTapped = { [weak self] show in
            _ = self?.createDetailsView(of: show)
        }
        
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
    
    private func createDetailsView(of show: Show) -> UIViewController {
        let vm = DetailsViewModel(show: show, favoriteService: serviceFactory.favoriteService)
        let detailsView = DetailsView(viewModel: vm)
        let vc = UIHostingController(rootView: detailsView)
        
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
}
