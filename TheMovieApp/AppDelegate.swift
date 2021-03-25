//
//  AppDelegate.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 16/03/2021.
//

import UIKit
import Resolver
import XCoordinator

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var mainWindow: UIWindow = UIWindow()
    private var appCoordinator = AppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ///
        LibsManager.shared.setupLibs(application, didFinishLaunchingWithOptions: launchOptions)
        ///
        Resolver.registerAllServices()
        ///
        mainWindow.backgroundColor = .white
        appCoordinator.strongRouter.setRoot(for: mainWindow)
        
        return true
    }

}

