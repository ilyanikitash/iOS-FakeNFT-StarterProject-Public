//
//  CartMainViewController.swift
//  FakeNFT
//
//  Created by Кирилл Дробин on 15.03.2025.
//

import UIKit

final class CartMainViewController: UIViewController {
    // MARK: - Properties
    var cartNftList = ["Проверка"] // toDo: список добавленных nft в корзину
    
    // MARK: - UI Elements
    
    private lazy var placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.text = NSLocalizedString("Корзина пуста", comment: "")
        placeholderLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return placeholderLabel
    }()
    
    private lazy var sortImage: UIImage = {
        let sortImage = UIImage(named: "Vector")
        return sortImage ?? UIImage()
    }()
    
    private lazy var nftListTableView: UITableView = {
        let list = UITableView()
        list.separatorStyle = .none
        list.backgroundColor = .clear
        return list
    }()
    
    private lazy var payFieldView: UIView = {
        let payView = UIView()
        payView.backgroundColor = UIColor(named: "greyForDarkMode")
        payView.layer.cornerRadius = 12
        payView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return payView
    }()
    
    private lazy var selectedNftCountLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.text = "3 NFT" // toDo: подгружать с сервака
        countLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return countLabel
    }()
    
    private lazy var priceNftLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "5,43 ETH" // toDo: подгружать с сервака
        priceLabel.textColor = UIColor(red: 28/255, green: 159/255, blue: 0/255, alpha: 1)
        priceLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return priceLabel
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor(named: "blackForDarkMode")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(UIColor(named: "whiteForDarkMode"), for: .normal)
        button.setTitle(NSLocalizedString("К оплате", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(switchToPayScreen), for: .touchUpInside) // toDo: следующий эпик
        return button
    }()

    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: sortImage, style: .plain, target: self, action: #selector(test))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "blackForDarkMode")
        view.backgroundColor = UIColor(named: "whiteForDarkMode")
        addSubviews()
        makeConstraints()
        nftListTableView.dataSource = self
        nftListTableView.delegate = self
        nftListTableView.register(NftCellView.self, forCellReuseIdentifier: "cell")
    }
    
    @objc func test() {
        print("test")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartMainScreenSetup()

    }
    // MARK: - Private Methods
    private func cartMainScreenSetup() {
        if cartNftList.isEmpty {
            nftListTableView.isHidden = true
            payFieldView.isHidden = true
            selectedNftCountLabel.isHidden = true
            priceNftLabel.isHidden = true
            payButton.isHidden = true
            
            placeholderLabel.isHidden = false
        } else {
            nftListTableView.isHidden = false
            payFieldView.isHidden = false
            selectedNftCountLabel.isHidden = false
            priceNftLabel.isHidden = false
            payButton.isHidden = false
            
            placeholderLabel.isHidden = true
        }
    }
    
    private func addSubviews() {
        [
            placeholderLabel,
            nftListTableView,
            payFieldView,
            selectedNftCountLabel,
            priceNftLabel,
            payButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            
            placeholderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            nftListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nftListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            nftListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            nftListTableView.bottomAnchor.constraint(equalTo: payFieldView.topAnchor, constant: 0),
            
            payFieldView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            payFieldView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            payFieldView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            payFieldView.heightAnchor.constraint(equalToConstant: 76),
            
            payButton.topAnchor.constraint(equalTo: payFieldView.topAnchor, constant: 16),
            payButton.leadingAnchor.constraint(equalTo: payFieldView.leadingAnchor, constant: 119),
            payButton.trailingAnchor.constraint(equalTo: payFieldView.trailingAnchor, constant: -16),
            payButton.bottomAnchor.constraint(equalTo: payFieldView.bottomAnchor, constant: -16),
            
            selectedNftCountLabel.topAnchor.constraint(equalTo: payFieldView.topAnchor, constant: 16),
            selectedNftCountLabel.leadingAnchor.constraint(equalTo: payFieldView.leadingAnchor, constant: 16),
            selectedNftCountLabel.trailingAnchor.constraint(equalTo: payFieldView.trailingAnchor, constant: -317),
            selectedNftCountLabel.bottomAnchor.constraint(equalTo: payFieldView.bottomAnchor, constant: -40),
            
            priceNftLabel.topAnchor.constraint(equalTo: payFieldView.topAnchor, constant: 38),
            priceNftLabel.leadingAnchor.constraint(equalTo: payFieldView.leadingAnchor, constant: 16),
            priceNftLabel.trailingAnchor.constraint(equalTo: payFieldView.trailingAnchor, constant: -280),
            priceNftLabel.bottomAnchor.constraint(equalTo: payFieldView.bottomAnchor, constant: -16),
        ])
    }
    
    @objc private func switchToPayScreen() {
        let payViewController = PayViewController()
        self.navigationController?.pushViewController(payViewController, animated: true)
    }
}

extension CartMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 } // toDo: подгружать с сервака
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 140 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NftCellView else { return NftCellView()}
        return cell
    }
    
}
