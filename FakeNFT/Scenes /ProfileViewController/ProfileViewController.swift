//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Давид Бекоев on 23.03.2025.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    //MARK: - Layout variables
    private lazy var editButton: UIButton = {
        let imageButton = UIImage(named: "Edit")
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(imageButton, for: .normal)
        button.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        return button
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Avatar"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.text = "Joaquin Phoenix"
        return label
    }()
    private lazy var bioTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 13, weight: .regular)
        textView.textColor = .black
        textView.text = """
                        Дизайнер из Казани, люблю цифровое искусство
                        и бейглы. В моей коллекции уже 100+ NFT,
                        и еще больше — на моём сайте.
                        Открыт к коллаборациям.
                        """
        textView.isEditable = false
        return textView
    }()
    
    private lazy var urlButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Joaquin Phoenix.com", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(openWebView), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            ProfileTableViewCell.self,
            forCellReuseIdentifier: ProfileTableViewCell.cellName
        )
        tableView.alwaysBounceVertical = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = false
        tableView.rowHeight = 54
        return tableView
    }()
    
    private var tableCells: [ProfileCellModel] = []
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableCells[indexPath.row].action()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileTableViewCell.cellName,
            for: indexPath
        ) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(
            name: tableCells[indexPath.row].name,
            count: tableCells[indexPath.row].count
        )
        
        return cell
    }
}

//MARK: - Private functions
private extension ProfileViewController {
    func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        fillTableCells()
        addSubViews()
        configureConstraints()
    }
    
    func addSubViews() {
        view.addSubview(editButton)
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(bioTextView)
        view.addSubview(urlButton)
        view.addSubview(tableView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -9),
            editButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 20),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 70),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            bioTextView.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioTextView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            bioTextView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            bioTextView.heightAnchor.constraint(equalToConstant: 75),
            
            urlButton.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            urlButton.topAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: 8),
            urlButton.heightAnchor.constraint(equalToConstant: 28),
            
            tableView.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: urlButton.bottomAnchor, constant: 40),
            tableView.heightAnchor.constraint(equalToConstant: 162)
        ])
    }
    
    func fillTableCells() {
        
        tableCells.append(
            ProfileCellModel(
                name: "Мои NFT",
                count: 112,
                action: { [weak self] in
                    guard self != nil else { return }
                    
                })
        )
        tableCells.append(
            ProfileCellModel(
                name: "Избранные NFT",
                count: 11,
                action: { [weak self] in
                    guard self != nil else { return }
                    
                })
        )
        tableCells.append(
            ProfileCellModel(
                name: "О разработчике",
                count: nil,
                action: { [weak self] in
                    guard let self = self else { return }
                    self.openWebView()
                })
        )
    }
    
    @objc
    func editProfile() {
        present(EditProfileViewController(), animated: true)
    }
    
    @objc
    func openWebView() {
        let webViewViewController = WebViewViewController()
        webViewViewController.hidesBottomBarWhenPushed = true
        present(webViewViewController,animated: true)
        navigationController?.pushViewController(webViewViewController, animated: true)
    }
}
