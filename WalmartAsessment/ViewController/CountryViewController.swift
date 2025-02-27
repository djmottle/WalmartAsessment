//
//  ViewController.swift
//  WalmartAsessment
//
//  Created by David Mottle on 2/26/25.
//

import UIKit

//MARK: - CountryViewController
class CountryViewController: UIViewController {
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = Constants.TableViewConstants.cellHeight
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    let viewModel: CountryViewModel
    
    init(viewModel: CountryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        configureUI()
        configureSearch()
        updateData()
        Task {
            await viewModel.fetchCountryData()
        }
    }
    
    //MARK: - Setting UI
    private func updateData(){
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showAlert(message: errorMessage)
            }
        }
    }
    
    private func configureSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search countries or capitals"
        definesPresentationContext = true
    }
    
    private func configureUI() {
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: Constants.TableViewConstants.cellIdentifier)
        view.addSubview(tableView)
        setupConstraints()
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = searchController.searchBar
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

//MARK: - TableView Datasource
extension CountryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCountries()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        let country = viewModel.country(at: indexPath.row)
        cell.configure(country: country)
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension CountryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterCountries(for: searchController.searchBar.text ?? "")
    }
}

//MARK: - Alert
extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
