//
//  AppDelegate.swift
//  BaseProject
//
//  Created by Fus on 15/05/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Override point for customization after application launch.
        AppFlowManager.shared.application(application,
                                          window: window!,
                                          didFinishLaunchingWithOptions: launchOptions)
        return true
    }

}
