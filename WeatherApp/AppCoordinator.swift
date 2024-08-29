//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import UIKit

public final class AppCoordinator {
    
    // MARK: - Static properties
    
    public static let instance = AppCoordinator()
    
    // MARK: - Properties
    
    private var apiService: DefaultAPIService?
    
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
        
        guard let apiService else { return }
        appFlow = AppFlow(window: window, apiService: apiService)
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
        
        var errorDescription: String? {
            switch self {
            case .lackOfConfigFile:
                return "brak pliku"
            case .invalidAPIKey:
                return "nie ma api key"
            case .servicesNotConfigured:
                return "service nil"
            }
        }
    }
}
