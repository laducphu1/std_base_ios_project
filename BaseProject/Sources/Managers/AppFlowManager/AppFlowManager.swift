//
//  AppFlowManager.swift
//  BaseProject
//
//  Created by Fus on 15/05/2022.
//

import UIKit

class AppFlowManager {
    
    weak var window: UIWindow!
    static var shared: AppFlowManager = AppFlowManager()
    
    func application(_ application: UIApplication, window: UIWindow, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.window = window
        showRootViewController()
        configureNavigationBar()
        self.window?.makeKeyAndVisible()
    }
    
    private func showRootViewController() {
        let homeVC = HomeVC()
        let navVC = BaseNavigationController(rootViewController: homeVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
    private func configureNavigationBar() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().layer.shadowColor = UIColor.clear.cgColor
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = Asset.Colors.mainColor.color
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.shadowColor = .white
            appearance.shadowImage = UIImage()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
