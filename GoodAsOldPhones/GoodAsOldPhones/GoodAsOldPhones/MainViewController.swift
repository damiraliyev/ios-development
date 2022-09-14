//
//  ViewController.swift
//  GoodAsOldPhones
//
//  Created by Damir Aliyev on 14.09.2022.
//

import UIKit

class MainViewController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.backgroundColor = .systemGray5
        delegate = self
        setupTabBar()
    }
    
    
    private func setupTabBar() {
        let productsViewController = ProductsViewController()
        productsViewController.tabBarItem =  UITabBarItem(title: "Products", image: UIImage(systemName: "phone.fill"), selectedImage: nil)
        
        
        let usViewController = UsViewController()
        usViewController.tabBarItem = UITabBarItem(title: "Us", image: UIImage(systemName: "person.fill"), selectedImage: nil)
        
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        viewControllers = [productsViewController, usViewController]
    }


}

extension MainViewController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
          return false // Make sure you want this as false
        }

        if fromView != toView {
          UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }

        return true
    }
}
