//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import CoreData
import UIKit

public final class AppCoordinator {
    
    // MARK: - Static properties
    
    public static let instance = AppCoordinator()
    
    // MARK: - Properties
    
    private var apiService: DefaultAPIService?
    private var coreDataService: CoreDataService?
    
    private var appFlow: AppFlow?
    private var window: UIWindow?
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - API
    
    public func start(window: UIWindow) {
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
        
        self.window = window

        getAPIKey() { [weak self] result in
            switch result {
            case .success(let apiKey):
                self?.apiService = DefaultAPIService(apiKey: apiKey)
            case .failure(let error):
                self?.handleError(error)
            }
        }
        
        configureCoreDataContainer() { [weak self] result in
            switch result {
            case .success(let container):
                self?.coreDataService = DefaultCoreDataService(container: container)
            case .failure(let error):
                self?.handleError(error)
            }
        }
        
        
        guard let apiService, let coreDataService else { return }
        appFlow = AppFlow(window: window, apiService: apiService, coreDataService: coreDataService)
        appFlow?.start()
    }
    
    // MARK: - Private
    
    private func getAPIKey(completion: @escaping (Result<String, AppError>) -> ()) {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist") else { completion(.failure(AppError.lackOfConfigFile))
            return
        }
        
        guard let config = NSDictionary(contentsOfFile: path) as? [String: AnyObject],
              let value = config[ConfigKeys.api] as? String else { 
            completion(.failure(AppError.invalidAPIKey))
            return
        }
        
        completion(.success(value))
    }
    
    private func configureCoreDataContainer(completion: @escaping (Result<NSPersistentContainer, AppError>) -> ()) {
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores { _ , error in
            if let error = error {
                completion(.failure(.coreDataError(error.localizedDescription)))
            }
            completion(.success(container))
        }
    }
    
    private func handleError(_ appError: AppError) {
        let alert = UIAlertController(title: "Błąd", message: appError.errorDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        window?.rootViewController?.present(alert, animated: true)
    }
}

extension AppCoordinator {
    
    private enum AppError: LocalizedError {
        case lackOfConfigFile
        case invalidAPIKey
        case servicesNotConfigured
        case coreDataError(String)
        
        var errorDescription: String? {
            switch self {
            case .lackOfConfigFile:
                return "Config.plist missing file"
            case .invalidAPIKey:
                return "Invalid API KEY"
            case .servicesNotConfigured:
                return "service nil"
            case .coreDataError(let error):
                return "CoreData error: \(error)"
            }
        }
    }
}
