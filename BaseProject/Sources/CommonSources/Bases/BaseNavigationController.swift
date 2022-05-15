//
//  BaseNavigationController.swift
//  Vebo
//
//  Created by Fus on 12/01/2022.
//

import UIKit

class BaseNavigationController: UINavigationController {
    fileprivate var duringPushAnimation = false

    // MARK: - Lifecycle
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        delegate = self
        configure()
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        duringPushAnimation = true

        super.pushViewController(viewController, animated: animated)
    }

    deinit {
        delegate = nil
        interactivePopGestureRecognizer?.delegate = nil
    }
    private func configure() {
      modalPresentationStyle = .overFullScreen
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
      navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
      navigationBar.isTranslucent = false
      navigationBar.shadowImage = UIImage()
    }
}

// MARK: - UINavigationControllerDelegate
extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let nav = navigationController as? BaseNavigationController else { return }

        nav.duringPushAnimation = false
    }
}

// MARK: - UIGestureRecognizerDelegate
extension BaseNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true // default value
        }

        // Disable pop gesture during pop animation and when user swipes quickly a couple of times
        return viewControllers.count > 1 && duringPushAnimation == false
    }
}
