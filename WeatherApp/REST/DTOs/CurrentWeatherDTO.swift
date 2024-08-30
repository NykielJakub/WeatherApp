//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import Foundation

struct CurrentWeatherDTO: Decodable {
    
    // MARK: - Properties
    
    let sunrise: Date
    let sunset: Date
    let temperature: Double
    let weather: [WeatherDescriptionDTO]
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
        case temperature = "temp"
        case weather
    }
    
    // MARK: - Initializer
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sunrise = try values.decode(Date.self, forKey: .sunrise)
        sunset = try values.decode(Date.self, forKey: .sunset)
        temperature = try values.decode(Double.self, forKey: .temperature)
        weather = try values.decode([WeatherDescriptionDTO].self, forKey: .weather)
    }
    
}
