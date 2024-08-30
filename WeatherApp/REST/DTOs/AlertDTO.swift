//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

struct AlertDTO: Decodable {
    
    // MARK: - Properties
    
    let sender: String
    let event: String
    let description: String
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case sender = "sender_name"
        case event
        case description
    }

    // MARK: - Initializer
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sender = try values.decode(String.self, forKey: .sender)
        event = try values.decode(String.self, forKey: .event)
        description = try values.decode(String.self, forKey: .description)
    }
    
}
