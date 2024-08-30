//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import Foundation

class DefaultAPIService: APIService {
    
    // MARK: - Properties
    
    private let apiKey: String
    
    // MARK: - Initializers
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    // MARK: - API
    
    func searchCities(for input: String, completion: @escaping (Result<[CityDTO], any Error>) -> ()) {
        let encodedInput = input.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? input
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(encodedInput)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let cityDTOs = try JSONDecoder().decode([CityDTO].self, from: data)
                completion(.success(cityDTOs))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getWeather(lat: Double, lon: Double, completion: @escaping (Result<CityWeatherDTO, Error>) -> ()) {
        let lang = Locale.current.minimalIdentifier()
        let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&lang=\(lang)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let cityWeatherDTO = try JSONDecoder().decode(CityWeatherDTO.self, from: data)
                completion(.success(cityWeatherDTO))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
