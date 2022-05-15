//
//  Utils.swift
//  BaseProject
//
//  Created by Fus on 15/05/2022.
//

import Foundation
import UIKit

typealias ConfirmButtonTapBlock = (_ alert: UIAlertController?, _ action: UIAlertAction?) -> Void

class Utils {
    /* Show Custom alert */

    static public func showOptionAlertController(title: String,
                                                 message: String,
                                                 _ completionHandler: (( _ alert: UIAlertController, _ action: UIAlertAction) -> Void)?) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
            completionHandler?(alert, action)
        }))
        let currentVC = UIViewController.topViewController
        currentVC?.present(alert, animated: true)
    }

    /* Show custom alert */

    static public func showAlertController(title: String, message: String, _ completionHandler: (( _ alert: UIAlertController, _ action: UIAlertAction) -> Void)?) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
            completionHandler?(alert, action)
        }))
        UIViewController.topViewController?.present(alert, animated: true)
    }
}
