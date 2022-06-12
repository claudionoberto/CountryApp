//
//  ViewController.swift
//  ChallengeDay59
//
//  Created by Claudio Noberto on 01/05/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    let tableView = UITableView()
    var countriestest: [Countries]?
    let searchController = UISearchController()
    let infoButton: UIButton = {
        let button = UIButton(type: .infoLight)
        return button
    }()
    let loadingAnimation: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        return activityIndicator
    }()
    var countries: [Countries]? {
        didSet {
            DispatchQueue.main.async {
                self.loadingAnimation.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    var errorAlert: String? {
        didSet {
            DispatchQueue.main.async {
                Alert.showBasic(title: "Erro", message: self.errorAlert, vc: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationController()
        configViews()
        configTableView()
        loadingAnimation.startAnimating()
        fetchData()
    }
   
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
        loadingAnimation.frame = view.frame
        loadingAnimation.center = view.center
    }
    
    func fetchData () {
        ServiceModel.getCountries { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.errorAlert = error.localizedDescription
                print(error.localizedDescription)
            case .success(let country):
                self?.countries = country
                self?.countriestest = country
            }
        }
    }
    
    @objc func infoAction() {
        Alert.showBasic(title: "", message: "Os dados dessa aplicação são retirados da REST Countries API ", vc: self)
    }
    
    func configViews() {
        view.addSubview(tableView)
        view.addSubview(loadingAnimation)
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    func configNavigationController() {
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
        infoButton.addTarget(self, action: #selector(infoAction), for: .touchUpInside)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filteringData(keywords: text)
    }
    
    func filteringData(keywords: String) {
        if keywords.isEmpty {
            countries = countriestest
            return
        }

        countries = countriestest?.filter({ countries in
            if let _ = countries.name.common.range(of: keywords, options: .caseInsensitive) {
                return true
            }
            
            return false
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rc = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell, let countries = countries else { return UITableViewCell() }
        rc.accessoryType = .disclosureIndicator
        rc.config(labelCell: countries[indexPath.row].name.common, imageCell: countries[indexPath.row].flags.png)
        return rc
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewControllerInstance = DetailViewController()
        let data = countries![indexPath.row]
        detailViewControllerInstance.config(countryName: data.name.common,
                                            countryPopulation: data.population,
                                            countryCapital: data.capital,
                                            countryRegion: data.region,
                                            countrySubRegion: data.subregion,
                                            imageCell: data.flags.png)
        navigationController?.pushViewController(detailViewControllerInstance, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
