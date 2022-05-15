//
//  BaseScrollView.swift
//  Vebo
//
//  Created by Fus on 12/01/2022.
//

import UIKit

class BaseScrollView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        contentInsetAdjustmentBehavior = .never
    }
}
