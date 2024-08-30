//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import Combine

final class DefaultSearchCityViewModel: SearchCityViewModel {
    
    // MARK: - Events
    
    private(set) lazy var fetchedCities = _fetchedCities.eraseToAnyPublisher()
    private(set) lazy var searchedCities = _searchedCities.eraseToAnyPublisher()
    private(set) var cities: [City] = []
    
    // MARK: - Properties
    
    private let _fetchedCities = PassthroughSubject<[City], Error>()
    private let _searchedCities = PassthroughSubject<[City], Error>()
    
    private let model: SearchCityModel
    private let router: SearchCityRouter
    
    // MARK: - Initializers
    
    init(model: SearchCityModel, router: SearchCityRouter) {
        self.model = model
        self.router = router
    }
    
    // MARK: - API
    
    func fetchCities(for input: String) {
        model.searchCities(for: input) { [weak self] result in
            switch result {
            case .success(let cities):
                self?.cities = cities
                self?._fetchedCities.send(cities)
            case .failure(let error):
                print("[Error]: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchSearchedCities() {
        _searchedCities.send(model.fetchSearchedCities())
    }
    
    func showWeather(for city: City) {
        router.invokeWeather(for: city)
    }
}
