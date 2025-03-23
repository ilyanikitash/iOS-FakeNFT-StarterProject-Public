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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userCartView.configure()
        setupTableView()
    }
    
    private func setupTableView() {
        userCartView.tableView.delegate = self
        userCartView.tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        
    }
}

extension UserCardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        54
    }
}

extension UserCardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCardTableViewCell.identifier, for: indexPath) as? UserCardTableViewCell else { return UITableViewCell() }
        return cell
    }
}
