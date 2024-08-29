//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import Combine

final class DefaultSearchCityRouter: SearchCityRouter {
    
    // MARK: - Events
    
    private(set) lazy var navigateToCityWeather = _navigateToCityWeather.eraseToAnyPublisher()
    
    // MARK: - Properties
    
    private let _navigateToCityWeather = PassthroughSubject<City, Error>()
    
    // MARK: - API
    
    func invokeWeather(for city: City) {
        _navigateToCityWeather.send(city)
    }
}
