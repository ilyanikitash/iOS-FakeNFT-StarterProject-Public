//
//  NftCellView.swift
//  FakeNFT
//
//  Created by Кирилл Дробин on 16.03.2025.
//

import UIKit

final class NftCellView: UITableViewCell {
    
    // MARK: - UI Elements
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.layer.backgroundColor = UIColor.green.cgColor // toDo: подгружать с сервака
        return image
    }()
    
    private lazy var nftNameLabel: UILabel = {
        let label = UILabel()
        label.text = "April" // toDo: подгружать с сервака
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var ratingPlaceholder: UILabel = {
        let rating = UILabel()
        rating.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        rating.textAlignment = .left
        rating.text = "★★★★★"
        rating.textColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        return rating
    }()

    private lazy var rating: UILabel = {
        let rating = UILabel()
        rating.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        rating.textAlignment = .left
        rating.text = "★★★" // toDo: подгружать с сервака
        rating.textColor = UIColor(red: 254/255, green: 239/255, blue: 13/255, alpha: 1)
        return rating
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Цена", comment: "")
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()

    private lazy var priceValueLabel: UILabel = {
        let label = UILabel()
        label.text = "13 ETH" // toDo: подгружать с сервака
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "nftDelete"), for: .normal)
        return button
    }()

    // MARK: - Cell init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: .none)
        addSubviews()
        makeConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetup() {
        // toDo: настройка параметров ячейки взависимости от загруженных данных
    }

    // MARK: - Private Methods
    private func addSubviews() {
        [
            image,
            nftNameLabel,
            ratingPlaceholder,
            rating,
            priceLabel,
            priceValueLabel,
            deleteButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.heightAnchor.constraint(equalToConstant: 108),
            image.widthAnchor.constraint(equalToConstant: 108),
            
            nftNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            nftNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 144),
            nftNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -94),
            nftNameLabel.widthAnchor.constraint(equalToConstant: 100),
            
            ratingPlaceholder.heightAnchor.constraint(equalToConstant: 13),
            ratingPlaceholder.widthAnchor.constraint(equalToConstant: 75),
            ratingPlaceholder.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            ratingPlaceholder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 144),
                      
            rating.heightAnchor.constraint(equalToConstant: 13),
            rating.widthAnchor.constraint(equalToConstant: 75),
            rating.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            rating.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 144),
            
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 74),
            priceLabel.leadingAnchor.constraint(equalTo: nftNameLabel.leadingAnchor, constant: 0),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -48),
            priceLabel.widthAnchor.constraint(equalToConstant: 40),
            
            priceValueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 94),
            priceValueLabel.leadingAnchor.constraint(equalTo: nftNameLabel.leadingAnchor, constant: 0),
            priceValueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            priceValueLabel.widthAnchor.constraint(equalToConstant: 100),
            
            deleteButton.centerYAnchor.constraint(equalTo: image.centerYAnchor, constant: 0),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22)
            
        ])
    }

}
