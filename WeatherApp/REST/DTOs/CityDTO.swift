//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

struct CityDTO: Decodable {
    
    // MARK: - Properties
    
    let name: String
    let localNames: [String: String]
    let latitude: Double
    let longitude: Double
    let country: String
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case latitude = "lat"
        case longitude = "lon"
        case country
    }
    
    // MARK: - Initializer
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        localNames = try values.decode([String: String].self, forKey: .localNames)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        country = try values.decode(String.self, forKey: .country)
    }
}
