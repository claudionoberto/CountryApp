//
//  TableViewCell.swift
//  ChallengeDay59
//
//  Created by Claudio Noberto on 09/05/22.
//

import SDWebImage
import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 0.1
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        constraints()
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 70),
            image.widthAnchor.constraint(equalToConstant: 130),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    public func config(labelCell: String, imageCell: String) {
        let imageURL = URL(string: imageCell)
        label.text = labelCell
        image.sd_setImage(with: imageURL)
    }
}
