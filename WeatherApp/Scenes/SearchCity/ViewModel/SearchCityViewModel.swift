//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import Combine

protocol SearchCityViewModel: AnyObject {
    
    // MARK: - Events
    
    var fetchedCities: AnyPublisher<[City], Error> { get }
    var cities: [City] { get }
    
    // MARK: - Methods
    
    func fetchCities(for input: String)
    func showWeather(for city: City)
}
