//
//  StringExtension.swift
//  BaseProject
//
//  Created by Fus on 15/05/2022.
//

import Foundation
import UIKit

extension String {
    func toNSError() -> NSError {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: self])
        return error
    }
    var isEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
