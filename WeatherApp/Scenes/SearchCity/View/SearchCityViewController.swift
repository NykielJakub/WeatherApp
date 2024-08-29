//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import Combine
import UIKit

final class SearchCityViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = ContentView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let searchResultsTableView = UITableView()
    
    private let viewModel: SearchCityViewModel
    
    private var isDynamicAvailable = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Initializers
    
    init(viewModel: SearchCityViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearch()
        setupSearchResultsTableView()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bindViewModelWithView()
        bindViewWithViewModel()
    }
    
    // MARK: - Private
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "search_placeholder".localized
        searchController.searchBar.delegate = self
        configureSearchMode()
    }
    
    private func setupSearchResultsTableView() {
        searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false
        searchResultsTableView.isHidden = true 
        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self
        searchResultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CityCell")
        
        view.addSubview(searchResultsTableView)
        NSLayoutConstraint.activate([
            searchResultsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchResultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigation() {
        title = "weather".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
    
    private func configureSearchMode() {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let config = NSDictionary(contentsOfFile: path) as? [String: AnyObject],
            let isDynamicSearchOn = config[ConfigKeys.dynamicSearch] as? Bool else {
            isDynamicAvailable = false
            return
        }
        isDynamicAvailable = isDynamicSearchOn
    }
    
    private func bindViewWithViewModel() {
        
    }
    
    private func bindViewModelWithView() {
        viewModel.fetchedCities
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] cities in
                print("Miasta: \(cities)")
                self?.searchResultsTableView.reloadData()
            })
            .store(in: &subscriptions)
    }
}

// MARK: - UISearchResultsUpdating

extension SearchCityViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if isDynamicAvailable {
            viewModel.fetchCities(for: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        viewModel.fetchCities(for: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResultsTableView.isHidden = true
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

// MARK: - UISearchBarDelegate

extension SearchCityViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return text.matches(regex: .searchRegex)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        #warning("TODO: Animacje")
        searchResultsTableView.isHidden = false
    }
}

extension SearchCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CityCell")
        
        let city = viewModel.cities[indexPath.row]
        cell.textLabel?.text = "\(city.name), Country: \(city.country)"
        cell.detailTextLabel?.text = "Lat: \(city.latitude), Lon: \(city.longitude)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showWeather(for: viewModel.cities[indexPath.row])
    }
}
