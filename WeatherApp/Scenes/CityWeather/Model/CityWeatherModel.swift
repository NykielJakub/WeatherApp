//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import Combine

protocol CityWeatherModel: AnyObject {
    
    // MARK: - Methods
    
    func getWeather(completion: @escaping (Result<CityWeather, Error>) -> ())
}
