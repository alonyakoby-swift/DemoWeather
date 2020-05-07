//
//  SceneDelegate.swift
//  DemoWeather
//
//  Created by Alon on 07.05.20.
//  Copyright © 2020 Weatherapp. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var aC: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
          
        let window = UIWindow(windowScene: scene)
        aC = AppCoordinator(window: window)
        aC?.start()
    }
    
    
}
