//
//  HouseListingTableViewCell.swift
//  HouseSharing
//
//  Created by 金融研發一部-謝宜軒 on 2023/9/23.
//

import UIKit

class HouseListingTableViewCell: UITableViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    let photoCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let sizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let roomsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let floorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let tagsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0 // 支持多行顯示
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)
        contentView.addSubview(photoCountLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(sizeLabel)
        contentView.addSubview(roomsLabel)
        contentView.addSubview(floorLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(tagsLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            photoCountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            photoCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            priceLabel.leadingAnchor.constraint(equalTo: photoCountLabel.trailingAnchor, constant: 8),
            priceLabel.centerYAnchor.constraint(equalTo: photoCountLabel.centerYAnchor),

            addressLabel.topAnchor.constraint(equalTo: photoCountLabel.bottomAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            sizeLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
            sizeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            roomsLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
            roomsLabel.leadingAnchor.constraint(equalTo: sizeLabel.trailingAnchor, constant: 8),

            floorLabel.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 8),
            floorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            ageLabel.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 8),
            ageLabel.leadingAnchor.constraint(equalTo: sizeLabel.trailingAnchor, constant: 8),

            tagsLabel.topAnchor.constraint(equalTo: floorLabel.bottomAnchor, constant: 8),
            tagsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tagsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tagsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with listing: HouseListing) {
        titleLabel.text = listing.title
        photoCountLabel.text = "照片數量：\(listing.photoCount)"
        priceLabel.text = "價格：\(listing.price)"
        addressLabel.text = "地址：\(listing.address)"
        sizeLabel.text = "大小：\(listing.size)"
        roomsLabel.text = "房間數：\(listing.rooms)"
        floorLabel.text = "樓層：\(listing.floor)"
        ageLabel.text = "屋齡：\(listing.age)"
        tagsLabel.text = "標籤：\(listing.tags.joined(separator: ", "))"

    }
}
