//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

protocol CoreDataService: AnyObject {
    
    // MARK: - Methods
    
    func saveCity(city: City)
    func fetchCities() -> [CityEntity]
}
