//
//  UserCardViewController.swift
//  FakeNFT
//
//  Created by Ilya Nikitash on 3/21/25.
//
import UIKit

final class UserCardViewController: UIViewController {
    private let userCartView = UserCardView()
    override func loadView() {
        self.view = userCartView
    }
}
