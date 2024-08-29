//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

class DefaultAPIService: APIService {
    
    // MARK: - Properties
    
    private let apiKey: String
    
    // MARK: - Initializers
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    // MARK: - Private
}
