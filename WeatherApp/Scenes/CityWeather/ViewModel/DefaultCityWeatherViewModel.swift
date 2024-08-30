//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

final class DefaultCityWeatherViewModel: CityWeatherViewModel {
    
    // MARK: - Properties
    
    private let model: CityWeatherModel
    
    // MARK: - Initializers
    
    init(model: CityWeatherModel) {
        self.model = model
    }
}
