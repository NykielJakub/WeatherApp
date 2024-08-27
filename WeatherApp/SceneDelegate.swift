//
// Copyright © 2024 Nykiel Jakub.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties
    
    private let appCoordinator: AppCoordinator = .instance
    
    // MARK: - API
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        appCoordinator.start(window: UIWindow(windowScene: windowScene))
    }
}
