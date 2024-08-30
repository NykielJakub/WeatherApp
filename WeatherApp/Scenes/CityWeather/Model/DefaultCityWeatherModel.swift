//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

final class DefaultCityWeatherModel: CityWeatherModel {
    
    // MARK: - Properties
    
    private let city: City
    
    private let apiService: APIService
    
    // MARK: - Initializers
    
    init(city: City, apiService: APIService) {
        self.city = city
        self.apiService = apiService
    }
    
    // MARK: - Methods
    
    func getWeather() {
        apiService.getWeather(lat: city.latitude, lon: city.longitude)
    }
    
}
