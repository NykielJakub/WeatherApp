//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

protocol SearchCityModel: AnyObject {
    
    // MARK: - Methods
    
    func searchCities(for input: String, completion: @escaping (Result<[City], Error>) -> ())
    func fetchSearchedCities() -> [City]
}
