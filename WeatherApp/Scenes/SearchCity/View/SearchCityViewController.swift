//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import UIKit

final class SearchCityViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = ContentView()
    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearch()
        setupNavigation()
    }
    
    // MARK: - Private
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "search_placeholder".localized
        searchController.searchBar.delegate = self
    }
    
    private func setupNavigation() {
        title = "weather".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
}

// MARK: - UISearchResultsUpdating

extension SearchCityViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}

// MARK: - UISearchBarDelegate

extension SearchCityViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return text.matches(regex: .searchRegex)
    }
}
