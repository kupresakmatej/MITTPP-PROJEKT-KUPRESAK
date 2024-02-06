//
//  SceneDelegate.swift
//  Shows
//
//  Created by Matej Kuprešak on 22.09.2023..
//

import Foundation
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var rootCoordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        rootCoordinator = RootCoordinator(serviceFactory: ((UIApplication.shared.delegate) as! AppDelegate).serviceFactory)

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootCoordinator!.start()
        self.window = window
        window.makeKeyAndVisible()
    }
}
