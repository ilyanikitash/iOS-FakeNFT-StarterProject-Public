//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Давид Бекоев on 23.03.2025.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let servicesAssembly: ServicesAssembly
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
