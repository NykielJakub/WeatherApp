//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import UIKit

class AppFlow {
    
    // MARK: - Properties
    
    private let apiService: APIService
    
    private let window: UIWindow
    
    // MARK: - Initializers
    
    init(window: UIWindow, apiService: APIService) {
        self.window = window
        self.apiService = apiService
    }
    
    // MARK: - API
    
    func start() {
        let screen = SearchCityScreen()
        let navigationController = UINavigationController(rootViewController: screen.viewController)
        navigationController.modalPresentationStyle = .fullScreen
        window.rootViewController?.present(navigationController, animated: true)
    }
}
