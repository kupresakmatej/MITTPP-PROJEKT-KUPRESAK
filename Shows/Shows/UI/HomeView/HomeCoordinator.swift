//
//  HomeCoordinator.swift
//  Shows
//
//  Created by Matej Kuprešak on 27.09.2023..
//

import Foundation
import UIKit
import SwiftUI

final class HomeCoordinator: Coordinator {
    private var navigationController: BaseNavigationController = BaseNavigationController()
    let serviceFactory: ServiceFactory
    
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    func start() -> UIViewController {
        return createHomeController()
    }
    
    private func createHomeController() -> UIViewController {
        let vm = HomeViewModel(favoriteService: serviceFactory.favoriteService)
        let homeView = HomeView(viewModel: vm)
        let vc = UIHostingController(rootView: homeView)
        vc.title = ""
        
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
