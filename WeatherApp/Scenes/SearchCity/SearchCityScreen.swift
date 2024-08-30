//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import UIKit

final class SearchCityScreen {

    // MARK: - Properties
    
    let viewController: UIViewController
    let router: SearchCityRouter
    
    // MARK: - Initializers
    
    init(apiService: APIService, coreDataService: CoreDataService) {
        let model = DefaultSearchCityModel(apiService: apiService, coreDataService: coreDataService)
        router = DefaultSearchCityRouter()
        let viewModel = DefaultSearchCityViewModel(model: model, router: router)
        viewController = SearchCityViewController(viewModel: viewModel)
    }
}
