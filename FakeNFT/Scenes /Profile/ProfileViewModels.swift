//
//  ProfileViewModels.swift
//  FakeNFT
//
//  Created by Давид Бекоев on 19.03.2025.
//

import Foundation

protocol ProfileViewModel {
    var profile: Profile? { get }
    func fetchProfile()
}
