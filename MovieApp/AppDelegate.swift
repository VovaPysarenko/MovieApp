//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 06.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = MainViewController()
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        return true
    }
}

