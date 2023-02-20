//
//  BaseTabBarController.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 3.02.2023.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = createViewControllers()
        
        tabBar.backgroundColor = .tertiarySystemGroupedBackground
        tabBar.tintColor = .link
    }

    private func createViewControllers() -> [UIViewController] {
        let todayViewController = TodayViewController()
        let todayNavigationController = UINavigationController(rootViewController: todayViewController)
        todayViewController.tabBarItem = .init(title: "Today", image: .init(systemName: ImageManager.todayIcon), tag: 2)
        todayNavigationController.navigationBar.prefersLargeTitles = true

        let appsViewController = AppsViewController()
        let appsNavigationController = UINavigationController(rootViewController: appsViewController)
        appsViewController.tabBarItem = .init(title: "Apps", image: .init(systemName: ImageManager.appsIcon), tag: 1)
        appsNavigationController.navigationBar.prefersLargeTitles = true

        let searchViewController = SearchViewController()
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        searchViewController.tabBarItem = .init(title: "Search", image: .init(systemName: ImageManager.searchIcon), tag: 0)
        searchNavigationController.navigationBar.prefersLargeTitles = true

        return [
            appsNavigationController,
            todayNavigationController,
            searchNavigationController
        ]
    }

}
