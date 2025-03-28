//
//  PayViewController.swift
//  FakeNFT
//
//  Created by Кирилл Дробин on 23.03.2025.
//

import SafariServices
import UIKit

final class PayViewController: UIViewController {
    // MARK: - Private Properties
    private var payStatus: Bool = /*true*/ false //для контроля реализации кода успешной/неуспешной оплаты
    
    private lazy var cryptoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var payFieldView: UIView = {
        let payView = UIView()
        payView.backgroundColor = UIColor(named: "greyForDarkMode")
        payView.layer.cornerRadius = 12
        payView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return payView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Совершая покупку, вы соглашаетесь с условиями"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var termsOfUseLink: UIButton = {
        let button = UIButton()
        button.setTitle("Пользовательского соглашения", for: .normal)
        button.setTitleColor(UIColor(red: 10/255, green: 132/255, blue: 255/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.addTarget(self, action: #selector(showTermsOfUse), for: .touchUpInside)
        return button
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor(named: "blackForDarkMode")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(UIColor(named: "whiteForDarkMode"), for: .normal)
        button.setTitle(NSLocalizedString("Оплатить", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(didPayButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = UIColor(named: "whiteForDarkMode")
        navigationBarSetup()
        cryptoCollectionView.dataSource = self
        cryptoCollectionView.delegate = self
        cryptoCollectionView.register(CryptoCellView.self, forCellWithReuseIdentifier: "cell")
        addSubviews()
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Private Methods
    private func navigationBarSetup() {
        self.navigationController?.navigationBar.tintColor = UIColor(named: "blackForDarkMode")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(backButton))
        
        self.navigationItem.title = "Выберите способ оплаты"
    }
    
    private func addSubviews() {
        [
            cryptoCollectionView,
            payFieldView,
            descriptionLabel,
            termsOfUseLink,
            payButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            cryptoCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cryptoCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            cryptoCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            cryptoCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 465),
            
            payFieldView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            payFieldView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            payFieldView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            payFieldView.heightAnchor.constraint(equalToConstant: 186),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: payFieldView.bottomAnchor, constant: -152),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 18),
            
            termsOfUseLink.bottomAnchor.constraint(equalTo: payFieldView.bottomAnchor, constant: -130),
            termsOfUseLink.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            termsOfUseLink.widthAnchor.constraint(equalToConstant: 202),
            termsOfUseLink.heightAnchor.constraint(equalToConstant: 18),
            
            payButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            payButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            payButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            payButton.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    
    private func showAlert(vc: UIViewController) {
        let alert = UIAlertController(title: "Не удалось произвести оплату", message: nil, preferredStyle: .alert)
        present(alert, animated: true)
                
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { action in
            alert.dismiss(animated: false)
        }))
        
        alert.addAction(UIAlertAction(title: "Повторить", style: .cancel, handler: { action in
            self.navigationController?.pushViewController(vc, animated: true)
            alert.dismiss(animated: false)
        }))
    }
    
    @objc private func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func showTermsOfUse() {
        if let url = URL(string: "https://yandex.ru/legal/practicum_termsofuse/") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    @objc private func didPayButton() {
        let successfulPayScreen = SuccessfulPayScreen()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self else { return }
            
            if self.payStatus == true {
                self.navigationController?.pushViewController(successfulPayScreen, animated: true)
            } else {
                self.showAlert(vc: successfulPayScreen)
            }
        }
    }
}

// MARK: - UICollectionView Setup
extension PayViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CryptoCellView else { return CryptoCellView()}
        
        cell.cellSetup(image: CryptoConstants.cryptoIcons[indexPath.row] ?? UIImage(),
                       name: CryptoConstants.cryptoNames[indexPath.row],
                       shortName: CryptoConstants.cryptoNamesShort[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellHeight: CGFloat = 46.0
        let cellsPerRow: CGFloat = 2.0
        let cellSpacing: CGFloat = 7.0
        
        let paddingWidth: CGFloat = 16 + 16 + (cellsPerRow - 1) * cellSpacing
        let availableWidth = collectionView.frame.width - paddingWidth
        let cellWidth =  availableWidth / CGFloat(cellsPerRow)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat { 7 }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CryptoCellView
        cell?.layer.cornerRadius = 12
        cell?.layer.borderWidth = 1
        cell?.layer.borderColor = UIColor.black.cgColor
        payButton.isEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CryptoCellView
        cell?.layer.borderColor = UIColor.clear.cgColor
    }
}
