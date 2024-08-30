//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import CoreData

final class DefaultCoreDataService: CoreDataService {
    
    // MARK: - Properties
    
    private let container: NSPersistentContainer
    
    // MARK: - Initializers
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func saveCity(city: City) {
        let cities = fetchCities()
        let cityToAdd = CityEntity(context: container.viewContext)
        cityToAdd.country = city.country
        cityToAdd.latitude = city.latitude
        cityToAdd.longitude = city.longitude
        cityToAdd.name = city.name
        do {
            if !cities.contains(where: { $0.latitude == cityToAdd.latitude || $0.longitude == cityToAdd.longitude }) {
                try container.viewContext.save()
            }
        } catch {
            print("error-Saving data")
        }
    }
    
    func fetchCities() -> [CityEntity] {
        let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        do {
            let cities = try container.viewContext.fetch(request)
            return cities
        } catch {
            print("Failed to fetch cities: \(error)")
            return []
        }
    }
}
