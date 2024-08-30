//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

protocol APIService: AnyObject {
    
    // MARK: - Methods
    
    func searchCities(for input: String, completion: @escaping (Result<[CityDTO], Error>) -> ())
    func getWeather(lat: Double, lon: Double)
}
