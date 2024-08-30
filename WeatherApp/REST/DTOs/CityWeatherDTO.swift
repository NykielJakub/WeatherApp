//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

struct CityWeatherDTO: Decodable {
    
    // MARK: - Properties
    
    let date: String
    
    // MARK: - Coding Keys
    
    // MARK: - Initializer
    
    enum CodingKeys: CodingKey {
    }
    
    init(from decoder: Decoder) throws {
        
    }
    
}
