//
//  AppDelegate.swift
//  GoodAsOldPhones
//
//  Created by Damir Aliyev on 14.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    let navigationController = UINavigationController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemBackground
        
        setupNavBar()
        
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = navigationController
        return true
    }
    
    func setupNavBar() {
        navigationController.viewControllers = [MainViewController()]
        
        let appearance = UINavigationBarAppearance()
        navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
    

}

