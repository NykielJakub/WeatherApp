//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import Combine
import UIKit

class AppFlow {
    
    // MARK: - Properties
    
    private let apiService: APIService
    private let coreDataService: CoreDataService
    private let window: UIWindow
    
    private var navigationController: UINavigationController?
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Initializers
    
    init(window: UIWindow, apiService: APIService, coreDataService: CoreDataService) {
        self.window = window
        self.apiService = apiService
        self.coreDataService = coreDataService
    }
    
    // MARK: - API
    
    func start() {
        subscriptions.removeAll()
        
        let screen = SearchCityScreen(apiService: apiService, coreDataService: coreDataService)
        
        screen.router.navigateToCityWeather
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] city in self?.showWeather(for: city) })
            .store(in: &subscriptions)
        
        let navigationController = UINavigationController(rootViewController: screen.viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.navigationController = navigationController
        
        window.rootViewController?.present(navigationController, animated: true)
    }
    
    func showWeather(for city: City) {
        let screen = CityWeatherScreen(city: city, apiService: apiService)
        
        coreDataService.saveCity(city: city)
        
        navigationController?.pushViewController(screen.viewController, animated: true)
    }
}
