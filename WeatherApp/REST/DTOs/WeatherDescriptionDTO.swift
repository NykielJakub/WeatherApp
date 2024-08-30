//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

struct WeatherDescriptionDTO: Decodable {
    
    // MARK: - Properties
    
    let conditions: String
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case conditions = "description"
    }

    // MARK: - Initializer
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        conditions = try values.decode(String.self, forKey: .conditions)
    }
    
}
