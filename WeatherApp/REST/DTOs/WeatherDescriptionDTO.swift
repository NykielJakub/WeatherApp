//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

struct WeatherDescriptionDTO: Decodable {
    
    // MARK: - Properties
    
    let description: String
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case description
    }

    // MARK: - Initializer
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        description = try values.decode(String.self, forKey: .description)
    }
    
}
