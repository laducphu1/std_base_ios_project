//
//  BaseViewController.swift
//  Vebo
//
//  Created by Fus on 11/01/2022.
//

import UIKit
import RxSwift
import Foundation

protocol CanRotate {

}

class OrientationManager {
    static var landscapeSupported: Bool = false
}

class BaseViewController: UIViewController, UIScrollViewDelegate, UINavigationControllerDelegate {

    let bag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    deinit {
        removeNotificationsObserver()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    /**
     On appear calls `showNavbar()` by default
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
        self.enableSwipePopViewController()
        if let viewControllers = self.navigationController?.viewControllers, viewControllers.count >= 2 {
            configButtonBack(isPresentVC: false)
        }
        if self.navigationController?.isBeingPresented ?? false {
            configButtonBack(isPresentVC: true)
        }
    }

    /**
     On disappear calls `stopFollowingScrollView()` to stop observing the current scroll view, and perform the tear down
     */
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    fileprivate func configUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        modalPresentationStyle = .overFullScreen
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    fileprivate func configButtonBack(isPresentVC: Bool) {
        var barButtonItem: UIBarButtonItem
        if  isPresentVC {
            barButtonItem = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .plain, target: self, action: #selector(BaseViewController.dismissViewController(showTabBar:)))
            navigationItem.setRightBarButton(barButtonItem, animated: true)
        } else {
            barButtonItem = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .plain, target: self, action: #selector(BaseViewController.popToRootViewController(toRoot:)))
            navigationItem.setLeftBarButton(barButtonItem, animated: true)
        }
    }

    @objc fileprivate func hideKeyboard() {
        view.endEditing(true)
    }

    // MARK: Function Public

    // MARK: Config UItabbarItem Helper
    func addLeftBarButtonItem(image: UIImage?, target: BaseViewController? = nil, action: Selector? = nil) {
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
        navigationItem.setLeftBarButton(barButtonItem, animated: true)
    }

    func addLeftBarButtonItem(title: String, target: BaseViewController, action: Selector) {
        let barButtonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        navigationItem.setLeftBarButton(barButtonItem, animated: true)
    }

    func addRightBarButtonItem(image: UIImage?, target: BaseViewController, action: Selector) {
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
        navigationItem.setRightBarButton(barButtonItem, animated: true)
    }

    func addRightBarButtonItem(title: String, target: BaseViewController, action: Selector) {
        let barButtonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        navigationItem.setRightBarButton(barButtonItem, animated: true)
    }

    // MARK: Function Push Pop Present....
    func pushViewController(viewCT: UIViewController) {
        guard let navi = self.navigationController else {
            return
        }
        hideKeyboard()
        viewCT.hidesBottomBarWhenPushed = true
        navi.pushViewController(viewCT, animated: true)
    }

    @objc func popToRootViewController(toRoot: Bool = false) {
        guard let navi = self.navigationController else {
            return
        }
        hideKeyboard()
        if toRoot {
            navi.popToRootViewController(animated: true)
        } else {
            navi.popViewController(animated: true)
        }
    }

    func popToViewController(viewCT: UIViewController) {
        guard let navi = self.navigationController else {
            return
        }
        hideKeyboard()
        navi.popToViewController(viewCT, animated: true)
    }

    func presentViewController(viewCT: UIViewController) {
        guard let navi = self.navigationController else {
            return
        }
        self.hideKeyboard()
        navi.present(viewCT, animated: true, completion: nil)
    }

    @objc func dismissViewController(showTabBar: Bool = false) {
        guard let navi = self.navigationController else {
            return
        }
        hideKeyboard()
        navi.dismiss(animated: true, completion: nil)
    }

    func disableSwipePopViewController() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    func enableSwipePopViewController() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}
