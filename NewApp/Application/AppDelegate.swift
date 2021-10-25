//
//  AppDelegate.swift
//  NewApp
//
//  Created by Admin on 21.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Public Properties
    
    var window: UIWindow?
    
    // MARK: - Public Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupInitialViewController()
        
        return true
    }
    
    // MARK: - Private Methods
    
    private func setupInitialViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let imagesView = PhotosViewController()
        imagesView.configurator = PhotosConfigurator()

        window?.rootViewController = UINavigationController(rootViewController: imagesView)
        window?.makeKeyAndVisible()
    }
    
}

