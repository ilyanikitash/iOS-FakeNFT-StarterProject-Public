//
//  EditProfileViewCintroller.swift
//  FakeNFT
//
//  Created by Давид Бекоев on 24.03.2025.
//


import UIKit
import Kingfisher

protocol EditProfileDelegate: AnyObject {
    func didUpdateProfile(_ profile: Profile)
}

final class EditProfileViewController: UIViewController {
    // MARK: - Properties
    weak var delegate: EditProfileDelegate?
    private var profile: Profile
    private var updatedAvatarURL: String?
    
    // MARK: - Initializers
    
    init(profile: Profile) {
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
    }
    
}

