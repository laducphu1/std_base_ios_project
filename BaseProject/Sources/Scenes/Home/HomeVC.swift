//
//  HomeVC.swift
//  BaseProject
//
//  Created by Fus on 15/05/2022.
//

import UIKit

class HomeVC: BaseViewController {

    // MARK: - Helper
    
    private func configureUI() {
        view.backgroundColor = Asset.Colors.mainColor.color
        title = "Base iOS Project"
    }

}

// MARK: - LifeCycle

extension HomeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}
