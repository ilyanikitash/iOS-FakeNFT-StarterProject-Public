//
//  UserCardViewController.swift
//  FakeNFT
//
//  Created by Ilya Nikitash on 3/21/25.
//
import UIKit

protocol LoadUserWebsiteDelegate: AnyObject {
    func loadWebsite(of userWebsite: String)
}

final class UserCardViewController: UIViewController {
    private let userCardView = UserCardView()
    private let statisticUsersListViewController: StatisticUsersListViewController
    private var user: UsersListModel = UsersListModel(name: "", avatar: "", description: "", website: "", nfts: [], rating: "", id: "")
    
    weak var loadUserWebsiteDelegate: LoadUserWebsiteDelegate?
    
    init(statisticUsersListViewController: StatisticUsersListViewController) {
        self.statisticUsersListViewController = statisticUsersListViewController
        super.init(nibName: nil, bundle: nil)
        statisticUsersListViewController.statisticUsersListVCDelegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = userCardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userCardView.configure()
        userCardView.openUserWebsiteDelegate = self
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        userCardView.tableView.isScrollEnabled = false
        userCardView.tableView.delegate = self
        userCardView.tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = .segmentActive
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func goBack() {
        self.dismiss(animated: true, completion: nil)
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
        cell.accessoryType = .disclosureIndicator
        cell.configure(with: user)
        return cell
    }
}

extension UserCardViewController: StatisticUsersListVCDelegate {
    func didTapCell(with user: UsersListModel) {
        self.user = user
        userCardView.updateProfile(of: user)
    }
}

extension UserCardViewController: OpenUserWebsiteDelegate {
    func openUserWebsite() {
        let webViewViewController = WebViewViewController()
        webViewViewController.modalPresentationStyle = .popover
        self.loadUserWebsiteDelegate = webViewViewController
        loadUserWebsiteDelegate?.loadWebsite(of: user.website)
        present(webViewViewController, animated: true, completion: nil)
    }
}

