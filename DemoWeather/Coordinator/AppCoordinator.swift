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
    
    /** This serves as a starting point. App coordinators are widely used as a standard pattern in case there are multiple possible starting points or to seperate certain views from each other.
     
     In my case I'm using a hardcoded list to use the starting point is a select number of cities option I would add to the table view or the navigation view an extra button to let the user add their cities.
     */
    
    func start() {
        let vm = CitiesViewModel()
        let vc = CitiesController.instantiate(viewModel: vm)
        let nav = LightNavigationController(rootViewController: vc)
        //Navigation Stack
        
        let attrs = [ NSAttributedString.Key.foregroundColor: UIColor.white ]
        UINavigationBar.appearance().titleTextAttributes = attrs
        nav.navigationBar.barTintColor = UIColor.black
        nav.navigationBar.barTintColor = .black
        //Navigation Properties
        
        window.tintColor = UIColor.orange
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}


class LightNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }

}
