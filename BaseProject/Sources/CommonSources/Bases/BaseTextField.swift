//
//  BaseTextField.swift
//  Vebo
//
//  Created by Fus on 12/01/2022.
//

import UIKit

class BaseTextField: UITextField {
    private let marginTextLeftRight: CGFloat = 15
    private let marginTextTopBottom: CGFloat = 2.5
    @IBInspectable var padding: CGFloat = 18

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
    }
}
