//
//  AppCoordinator.swift
//  DemoWeather
//
//  Created by Alon on 07.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let vm = CitiesViewModel()
        let vc = CitiesController.instantiate(viewModel: vm)
        let nav = UINavigationController(rootViewController: vc)
        let attrs = [ NSAttributedString.Key.foregroundColor: UIColor.white ]
        UINavigationBar.appearance().titleTextAttributes = attrs
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.barTintColor = .white
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}
