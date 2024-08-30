//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

final class DefaultSearchCityModel: SearchCityModel {
    
    // MARK: - Properties
    
    private let apiService: APIService
    private let coreDataService: CoreDataService
    private let mapper = DtoToDomainMapper()
    
    // MARK: - Initializers
    
    init(apiService: APIService, coreDataService: CoreDataService) {
        self.apiService = apiService
        self.coreDataService = coreDataService
    }
    
    // MARK: - API
    
    func searchCities(for input: String, completion: @escaping (Result<[City], any Error>) -> ()) {
        apiService.searchCities(for: input) { [weak self] result in
            switch result {
            case .success(let cities):
                completion(.success(cities.compactMap { self?.mapper.city(from: $0) }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchSearchedCities() -> [City] {
        coreDataService.fetchCities()
            .compactMap {
                return City(name: $0.name ?? "", latitude: $0.latitude, longitude: $0.longitude, country: $0.country ?? "")
            }
    }
}
