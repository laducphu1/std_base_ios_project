//
//  UIHelper.swift
//  BaseProject
//
//  Created by Fus on 15/05/2022.
//

import Foundation
import SVProgressHUD
import Toaster
import UIKit

class UIHelper {

    static func showError(_ error: String?) {
        guard let error = error else {
            return
        }
        func show() {
            UIHelper.showToast(error)
        }

        if Thread.isMainThread {
            show()
        } else {
            DispatchQueue.main.async {
                show()
            }
        }
    }

    static func showLoading() {
        func show() {
            SVProgressHUD.show()
        }

        if Thread.isMainThread {
            show()
        } else {
            DispatchQueue.main.async {
                show()
            }
        }
    }

    static func hideLoading() {
        func hide() {
            SVProgressHUD.dismiss()
        }

        if Thread.isMainThread {
            hide()
        } else {
            DispatchQueue.main.async {
                hide()
            }
        }
    }

    static func showToast(_ message: String?) {
        guard let message = message else {return}
        ToastCenter.default.cancelAll()
        Toast(text: message, delay: 0, duration: 2).show()
    }

    static func configureToastView() {
        ToastView.appearance().textInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        ToastView.appearance().bottomOffsetPortrait = 40
        ToastView.appearance().backgroundColor = UIColor.black
        ToastView.appearance().textColor = UIColor.white
        ToastView.appearance().shadowColor = UIColor.black
        ToastView.appearance().shadowOffset = CGSize(width: 2, height: 4)
        ToastView.appearance().shadowOpacity = 0.15
        ToastView.appearance().shadowRadius = 2
        ToastView.appearance().useSafeAreaForBottomOffset = true
    }
}
