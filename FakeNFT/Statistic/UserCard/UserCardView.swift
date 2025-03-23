//
//  UserCardView.swift
//  FakeNFT
//
//  Created by Ilya Nikitash on 3/21/25.
//
import UIKit

final class UserCardView: UIView {
    private lazy var avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stub_avatar")
        imageView.layer.cornerRadius = 35
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var siteButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.backgroundColor = .background
        button.layer.borderColor = UIColor.segmentActive.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Перейти на сайт пользователя", for: .normal)
        button.setTitleColor(.segmentActive, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func configure() {
        backgroundColor = .background
        
        tableView.register(
            UserCardTableViewCell.self,
            forCellReuseIdentifier: UserCardTableViewCell.identifier
        )
        
        addSubview(avatar)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(siteButton)
        addSubview(tableView)
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            avatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatar.heightAnchor.constraint(equalToConstant: 70),
            avatar.widthAnchor.constraint(equalToConstant: 70),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 16),
            //nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 41),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 20),
            
            siteButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 28),
            siteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            siteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: siteButton.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
