//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import UIKit

public final class AppCoordinator {
    
    // MARK: - Static properties
    
    public static let instance = AppCoordinator()
    
    // MARK: - Properties
    
    private var appFlow: AppFlow?
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - API
    
    public func start(window: UIWindow) {
        appFlow = AppFlow(window: window)
        appFlow?.start()
    }
}
