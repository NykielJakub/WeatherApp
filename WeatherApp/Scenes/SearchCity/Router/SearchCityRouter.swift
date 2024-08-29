//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import Combine

protocol SearchCityRouter: AnyObject {
    
    // MARK: - Events
    
    var navigateToCityWeather: AnyPublisher<City, Error> { get }
    
    // MARK: - Methods
    
    func invokeWeather(for city: City)
}
