//
//  StatisticUsersListViewController.swift
//  FakeNFT
//
//  Created by Ilya Nikitash on 3/14/25.
//
import UIKit

final class StatisticUsersListViewController: UIViewController {
    private let statisticUsersListView = StatisticUsersListView()
    private let mockUsers: [StatisticUsersListCellModel] = [
        StatisticUsersListCellModel(avatar: UIImage(named: "stub_avatar") ?? UIImage(), name: "Alex", nftCount: 45),
        StatisticUsersListCellModel(avatar: UIImage(named: "stub_avatar") ?? UIImage(), name: "Bill", nftCount: 134),
        StatisticUsersListCellModel(avatar: UIImage(named: "stub_avatar") ?? UIImage(), name: "Alla", nftCount: 67),
        StatisticUsersListCellModel(avatar: UIImage(named: "stub_avatar") ?? UIImage(), name: "Mads", nftCount: 76),
    ]
//MARK: - Lifecycle
    override func loadView() {
        self.view = statisticUsersListView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        statisticUsersListView.configure()
        setupNavigationBar()
        setupTableView()
        statisticUsersListView.statisticUsersListViewDelegate = self
    }
    
    private func setupTableView() {
        statisticUsersListView.usersListTableView.dataSource = self
        statisticUsersListView.usersListTableView.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .background
        navigationItem.rightBarButtonItem = statisticUsersListView.sortButton
    }
}

extension StatisticUsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
}

extension StatisticUsersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mockUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticUsersListTableViewCell.identifier, for: indexPath) as? StatisticUsersListTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let user = mockUsers[indexPath.row]
        cell.configure(with: user)
        return cell
    }
}

extension StatisticUsersListViewController: StatisticUsersListViewDelegate {
    func clickSortButton() {
        let nameAction = SortAlertPresenter.createAction(title: SortCases.name.title, style: .default) { _ in
            print("name sort")
        }
        let rateAction = SortAlertPresenter.createAction(title: SortCases.rate.title, style: .default) { _ in
            print("rate sort")
        }
        let cancelAction = SortAlertPresenter.createAction(title: "Закрыть", style: .cancel)
        
        SortAlertPresenter.present(title: nil, message: "Сортировка", actions: nameAction, rateAction, cancelAction, from: self)
    }
}
