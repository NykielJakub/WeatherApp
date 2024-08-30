//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

final class DefaultCityWeatherModel: CityWeatherModel {
    
    // MARK: - Properties
    
    private let city: City
    
    private let apiService: APIService
    private let mapper = DtoToDomainMapper()
    
    // MARK: - Initializers
    
    init(city: City, apiService: APIService) {
        self.city = city
        self.apiService = apiService
    }
    
    // MARK: - Methods
    
    func getWeather(completion: @escaping (Result<CityWeather, Error>) -> ()) {
        apiService.getWeather(lat: city.latitude, lon: city.longitude) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let dto):
                completion(.success(self.mapper.cityWeather(from: dto, cityName: city.name)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
