//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import Combine

final class DefaultCityWeatherViewModel: CityWeatherViewModel {
    
    // MARK: - Events
    
    private(set) lazy var cityWeather = _cityWeather.eraseToAnyPublisher()
    
    // MARK: - Properties
    
    private let model: CityWeatherModel
    
    private let _cityWeather = PassthroughSubject<CityWeather, Error>()
    
    // MARK: - Initializers
    
    init(model: CityWeatherModel) {
        self.model = model
    }
    
    // MARK: - API
    
    func fetchData() {
        model.getWeather() { [weak self] result in
            switch result {
            case .success(let weather):
                self?._cityWeather.send(weather)
            case .failure(let failure):
                #warning("TODO: Handle errors")
            }
        }
    }
}
