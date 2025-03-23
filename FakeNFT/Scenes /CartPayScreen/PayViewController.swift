//
//  PayViewController.swift
//  FakeNFT
//
//  Created by Кирилл Дробин on 23.03.2025.
//

import UIKit

final class PayViewController: UIViewController {
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "blackForDarkMode")
        self.navigationItem.title = "Выберите способ оплаты"
        self.navigationItem.titleView?.tintColor = UIColor(named: "blackForDarkMode")
        view.backgroundColor = UIColor(named: "whiteForDarkMode")

    }

}
