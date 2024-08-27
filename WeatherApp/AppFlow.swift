//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import UIKit

class AppFlow {
    
    // MARK: - Properties
    
    private let window: UIWindow
    
    // MARK: - Initializers
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - API
    
    func start() {
        let screen = SearchCityScreen()
        window.rootViewController = screen.viewController
        window.makeKeyAndVisible()
    }
}
