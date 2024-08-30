//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import UIKit

final class CityWeatherScreen {
    
    // MARK: - Properties
    
    let viewController: UIViewController
    
    // MARK: - Initializers
    
    init() {
        let model = DefaultCityWeatherModel()
        let viewModel = DefaultCityWeatherViewModel(model: model)
        viewController = CityWeatherViewController(viewModel: viewModel)
    }
}
