//
//  DetailViewController.swift
//  ChallengeDay59
//
//  Created by Claudio Noberto on 10/05/22.
//

import SDWebImage
import UIKit

class DetailViewController: UIViewController {
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 0.1
        imageView.backgroundColor = .systemGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let stackLabel: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    private let countryName: UILabel = {
        let label = UILabel()
        return label
    }()
    private let countryCapital: UILabel = {
        let label = UILabel()
        return label
    }()
    private let countryRegion: UILabel = {
        let label = UILabel()
        return label
    }()
    private let countryPopulation: UILabel = {
        let label = UILabel()
        return label
    }()
    private let countrySubRegion: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        view.addSubview(image)
        view.addSubview(stackLabel)
        let labelsArray = [countryName,countryCapital,countryRegion,countrySubRegion,countryPopulation]
        labelsArray.forEach { label in stackLabel.addArrangedSubview(label)}
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        constraintsConfig()
    }
    
    private func constraintsConfig() {
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 110),
            image.widthAnchor.constraint(equalToConstant: 200),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            stackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 50),
            stackLabel.heightAnchor.constraint(equalToConstant: 150),
            stackLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    public func config(countryName: String, countryPopulation: Int,countryCapital: [String]?, countryRegion: String, countrySubRegion: String?,imageCell: String) {
        let imageURL = URL(string: imageCell)
        image.sd_setImage(with: imageURL)
        self.countryName.text = "Name: \(countryName)"
        self.countryPopulation.text = "Population: \(countryPopulation.commaRepresentation)"
        self.countryCapital.text = "Capital: \(countryCapital?[0] ?? "")"
        self.countryRegion.text = "Region: \(countryRegion)"
        self.countrySubRegion.text = "Subregion: \(countrySubRegion ?? "")"
    }
}
