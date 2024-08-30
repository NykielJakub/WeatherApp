//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import Combine

protocol CityWeatherViewModel: AnyObject {
    
    // MARK: - Properties
    
    var cityWeather: AnyPublisher<CityWeather, Error> { get }
    
    // MARK: - Methods
    
    func fetchData()
}
