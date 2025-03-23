//
//  UserCartTableViewCell.swift
//  FakeNFT
//
//  Created by Ilya Nikitash on 3/21/25.
//
import UIKit

final class UserCardTableViewCell: UITableViewCell {
    
    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 1
        label.text = "TEST"
        label.textColor = .segmentActive
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let identifier = "UserCardTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellLabel)
        NSLayoutConstraint.activate([
            cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
