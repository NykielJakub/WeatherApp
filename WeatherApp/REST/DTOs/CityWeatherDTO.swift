//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

struct CityWeatherDTO: Decodable {
    
    // MARK: - Properties
    
    let current: CurrentWeatherDTO
    let alerts: [AlertDTO]?
    
    // MARK: - Coding Keys
    
    // MARK: - Initializer
    
    enum CodingKeys: CodingKey {
        case current
        case alerts
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        current = try values.decode(CurrentWeatherDTO.self, forKey: .current)
        alerts = try values.decodeIfPresent([AlertDTO].self, forKey: .alerts)
    }
    
}
