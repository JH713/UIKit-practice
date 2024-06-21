//
//  TabBarController.swift
//  SelfSizingScrollView
//
//  Created by 이지현 on 6/21/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    
        setupTabBar()
    }
    
    private func setupTabBar() {
        viewControllers = [
            makeViewController(viewController: ScrollViewController.self, title: "Scroll View", image: UIImage(systemName: "scroll")),
            makeViewController(viewController: TableViewController.self, title: "Table View", image: UIImage(systemName: "rectangle.split.1x2.fill")),
            makeViewController(viewController: CollectionViewController.self, title: "Collection View", image: UIImage(systemName: "rectangle.grid.3x2.fill"))
        ]
        
        tabBar.backgroundColor = .systemBackground
    }

    private func makeViewController(viewController: UIViewController.Type, title: String, image: UIImage?) -> UIViewController {
        let vc = viewController.init()
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }

}
