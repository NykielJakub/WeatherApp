//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import UIKit

extension SearchCityViewController {
    
    final class ContentView: UIView {
        
        // MARK: - Properties
        
        private let titleLabel = UILabel()
        private let tableView = UITableView()
        
        private var searchedCities: [City] = []
        
        // MARK: - Initializers
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupComponents()
            setupLayout()
        }
        
        required init?(coder: NSCoder) { nil }
        
        // MARK: - API
        
        func set(_ cities: [City]) {
            searchedCities = cities
            tableView.reloadData()
        }
        
        // MARK: - Methods
        
        private func setupComponents() {
            backgroundColor = .white
            titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
            titleLabel.text = "recent_searches".localized
            titleLabel.textColor = .black
            
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchedCell")
        }
        
        private func setupLayout() {
            tableView.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(titleLabel)
            addSubview(tableView)
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
                titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                
                tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            ])
        }
    }
}

extension SearchCityViewController.ContentView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SearchedCell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SearchedCell")
        
        let city = searchedCities[indexPath.row]
        cell.textLabel?.text = "\(city.name)"
        cell.detailTextLabel?.text = "\("country".localized): \(city.country), Lat: \(city.latitude), Lon: \(city.longitude)"
        
        return cell
    }
    
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            /*viewModel*/.showWeather(for: searchedCities[indexPath.row])
//        }
}
