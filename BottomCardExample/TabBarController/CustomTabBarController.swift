//
//  CustomTabBarController.swift
//  BottomCardExample
//
//  Created by Станислав Шияновский on 9/23/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public class CustomTabBarController: UITabBarController {

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let main = MainViewController()
        let mainIcon = UIImage(named: "News")
        main.tabBarItem = UITabBarItem(title: "Отзыв", image: mainIcon, tag: 0)
        
        viewControllers = [main]
    }
}
