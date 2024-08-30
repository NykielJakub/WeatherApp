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
        let context = container.viewContext
        
        let fetchExistingCitiesRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        fetchExistingCitiesRequest.predicate = NSPredicate(format: "name == %@", city.name)
        
        do {
            let existingCities = try context.fetch(fetchExistingCitiesRequest)
            if existingCities.isEmpty {
                let cityToAdd = CityEntity(context: context)
                cityToAdd.country = city.country
                cityToAdd.latitude = city.latitude
                cityToAdd.longitude = city.longitude
                cityToAdd.name = city.name
                
                try context.save()
            }
        } catch {
            print("Error fetching or saving data: \(error.localizedDescription)")
        }
    }
    
    func fetchCities() -> [CityEntity] {
        let context = container.viewContext
        let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        
        do {
            let cities = try context.fetch(request)
            return cities
        } catch {
            print("Failed to fetch cities: \(error)")
            return []
        }
    }
}
